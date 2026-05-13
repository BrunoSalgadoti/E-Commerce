import 'dart:async';

import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/core/auth_service.dart';
import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/features/admin/users/favorites/favorites_manager.dart';
import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/sales/delivery.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/db_api/config_environment_variables.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class UserManager extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  bool _loading = false;
  bool _newUserAccount = false;
  bool _editingCategories = false;
  bool _loadingFace = false;
  bool _loadingGoogle = false;

  Users? users;

  UserManager() {
    _authService.setLanguageCode('pt-BR');

    if (_authService.currentUser != null) {
      initializeUser();
    }
  }

  bool get loading => _loading;
  bool get editingCategories => _editingCategories;
  bool get loadingFace => _loadingFace;
  bool get loadingGoogle => _loadingGoogle;
  bool get isLoggedIn => users != null;
  bool get adminEnable => users != null && users!.admin;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set editingCategories(bool value) {
    _editingCategories = value;
    notifyListeners();
  }

  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  set loadingGoogle(bool value) {
    _loadingGoogle = value;
    notifyListeners();
  }

  void signOut(BuildContext context) {
    _authService.signOut();

    users = null;

    notifyListeners();

    final favoritesManager = Provider.of<FavoritesManager>(
      context,
      listen: false,
    );

    favoritesManager.updateUser(null);
  }

  Future<void> _loadCurrentUser({
    BuildContext? context,
    User? user,
  }) async {
    try {
      final currentUser = user ?? _authService.currentUser;

      if (currentUser != null && currentUser.uid.isNotEmpty) {
        final docUsers = await _firestoreService.getDocument(
          collection: "users",
          docId: currentUser.uid,
        );

        users = Users.fromDocument(docUsers);

        final docAdmin = await _firestoreService.getDocument(
          collection: "admins",
          docId: users?.id ?? '',
        );

        if (docAdmin.exists) {
          users?.admin = true;
        }

        if (context != null) {
          final favoritesManager = Provider.of<FavoritesManager>(
            context,
            listen: false,
          );

          favoritesManager.updateUser(users?.id);
        }

        notifyListeners();
      }
    } catch (error) {
      reportNoFatalErrorToCrashlytics(
        error: "$error",
        stackTrace: StackTrace.current,
        information:
        "Erro na Classe: UserManager no método _loadCurrentUser()",
      );

      MonitoringLogger().logError(
        'Erro ao carregar CurrentUser: $error',
      );
    }
  }

  Future<void> createAuxAndAdminsIfNotExists({
    required bool firstStart,
  }) async {
    if (kDebugMode && firstStart) {
      MonitoringLogger().logInfo(
        'Info: Verifier createAuxAndAdminsIfNotExists',
      );

      final adminsQuery = await _firestoreService.getCollection(
        collection: "admins",
      );

      final usersQuery = await _firestoreService.getCollection(
        collection: "users",
      );

      if (adminsQuery.docs.isEmpty && usersQuery.docs.isNotEmpty) {
        await _firestoreService.setDocument(
          collection: "admins",
          docId: users!.id!,
          data: {
            "user": users!.id,
          },
        );

        users!.admin = true;
      }

      final deliveryDoc = await _firestoreService.getDocument(
        collection: "aux",
        docId: "delivery",
      );

      if (!deliveryDoc.exists) {
        await _firestoreService.setDocument(
          collection: "aux",
          docId: "delivery",
          data: Delivery().toMap(),
        );
      }

      final orderCounterDoc = await _firestoreService.getDocument(
        collection: "aux",
        docId: "orderCounter",
      );

      if (!orderCounterDoc.exists) {
        await _firestoreService.setDocument(
          collection: "aux",
          docId: "orderCounter",
          data: {
            "current": 1,
          },
        );
      }
    }
  }

  Future<void> verifyEmailWithCode(
      BuildContext context,
      String oobCode,
      ) async {
    try {
      await _authService.checkActionCode(oobCode);

      await _authService.applyActionCode(oobCode);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail verificado com sucesso!'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erro ao verificar e-mail: $e');
    }
  }

  Future<void> sendPasswordResetEmailRequest({
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    try {
      await _authService.sendPasswordReset(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: AppConfigKey.linkRecoverPasswordInWeb,
          handleCodeInApp: false,
          iOSBundleId: null,
          androidPackageName: null,
          androidInstallApp: false,
        ),
      );

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(e.message ?? "Erro desconhecido");
    } catch (e) {
      onFail("Erro inesperado: $e");
    }
  }

  Future<void> confirmNewPassword({
    required String oobCode,
    required String newPassword,
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    try {
      await _authService.confirmPasswordReset(
        code: oobCode,
        newPassword: newPassword,
      );

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(e.message ?? "Erro desconhecido");
    } catch (e) {
      onFail("Erro inesperado: $e");
    }
  }

  Future<void> initializeUser({
    BuildContext? context,
  }) async {
    final currentUser = _authService.currentUser;

    if (currentUser != null) {
      try {
        final docUsers = await _firestoreService.getDocument(
          collection: "users",
          docId: currentUser.uid,
        );

        users = Users.fromDocument(docUsers);

        notifyListeners();
      } catch (error) {
        debugPrint('Erro ao inicializar usuário: $error');
      }
    }
  }

  Future<void> signInWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace(
      'sign-in-email',
      shouldStart: true,
    );

    loading = true;

    try {
      final result = await _authService.signIn(
        email: users.email,
        password: users.password!,
      );

      await _loadCurrentUser(
        user: result.user,
        context: context,
      );

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }

    loading = false;

    PerformanceMonitoring().stopTrace('sign-in-email');
  }

  Future<void> singUpWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace(
      'sing-up-email',
      shouldStart: true,
    );

    loading = true;

    try {
      final result = await _authService.signUp(
        email: users.email,
        password: users.password!,
      );

      users.id = result.user!.uid;
      users.policyAndTerms = true;

      this.users = users;

      await users.saveUserData();

      _newUserAccount = true;

      await _updateMonthlyNewUsers();

      if (context != null) {
        final favoritesManager = Provider.of<FavoritesManager>(
          context,
          listen: false,
        );

        favoritesManager.updateUser(users.id);
      }

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }

    loading = false;

    PerformanceMonitoring().stopTrace('sing-up-email');
  }

  Future<void> loginOrSingUpWithFacebook({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace(
      'login-facebook',
      shouldStart: true,
    );

    try {
      loadingFace = true;

      if (kIsWeb) {
        await FacebookAuth.i.webAndDesktopInitialize(
          appId: Config.facebookAppId,
          cookie: true,
          xfbml: true,
          version: "v17.0",
        );
      }

      final result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          final accessToken = result.accessToken!;

          final credential = FacebookAuthProvider.credential(
            accessToken.tokenString,
          );

          final userCredential =
          await _authService.signInWithCredential(
            credential,
          );

          final user = userCredential.user;

          if (user != null) {
            final doc = await _firestoreService.getDocument(
              collection: "users",
              docId: user.uid,
            );

            if (doc.exists) {
              users = Users.fromDocument(doc);

              await users?.updateUserData();
            } else {
              users = Users(
                email: user.email ?? "",
                userName: user.displayName,
                id: user.uid,
                phoneNumber: user.phoneNumber ?? "",
                userPhotoURL: user.photoURL ?? "",
              );

              await users?.saveUserData();

              _newUserAccount = true;

              await _updateMonthlyNewUsers();
            }

            if (context != null) {
              final favManager = Provider.of<FavoritesManager>(
                context,
                listen: false,
              );

              favManager.updateUser(users?.id);
            }

            loadingFace = false;

            onSuccess?.call();
          }

          break;

        case LoginStatus.failed:
          onFail!("Facebook login failed! ${result.status}");
          loadingFace = false;
          break;

        case LoginStatus.cancelled:
          onFail!("Login cancelled by user! ${result.status}");
          loadingFace = false;
          break;

        case LoginStatus.operationInProgress:
          loadingFace = true;
          break;
      }
    } on FirebaseAuthException catch (error) {
      onFail!(getErrorString(error.code));

      loadingFace = false;
    }

    PerformanceMonitoring().stopTrace('login-facebook');
  }

  Future<void> loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace(
      'login-google',
      shouldStart: true,
    );

    try {
      loadingGoogle = true;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();

        provider.addScope(
          'https://www.googleapis.com/auth/contacts.readonly',
        );

        provider.setCustomParameters({
          'login_hint': 'user@example.com',
        });

        await _authService.signInWithRedirect(provider);

        return;
      }

      await GoogleSignIn.instance.initialize();

      final googleUser =
      await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.idToken,
      );

      final userCredential =
      await _authService.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        final doc = await _firestoreService.getDocument(
          collection: "users",
          docId: user.uid,
        );

        if (doc.exists) {
          users = Users.fromDocument(doc);

          await users?.updateUserData();
        } else {
          users = Users(
            email: user.email ?? "",
            userName: user.displayName,
            id: user.uid,
            phoneNumber: user.phoneNumber ?? "",
            userPhotoURL: user.photoURL ?? "",
          );

          await users?.saveUserData();

          _newUserAccount = true;

          await _updateMonthlyNewUsers();
        }

        if (context != null) {
          final favManager = Provider.of<FavoritesManager>(
            context,
            listen: false,
          );

          favManager.updateUser(users?.id);
        }

        onSuccess?.call();
      } else {
        onFail?.call("Erro ao autenticar usuário.");
      }

      loadingGoogle = false;
    } on FirebaseAuthException catch (error) {
      onFail?.call(getErrorString(error.code));

      loadingGoogle = false;
    } catch (e) {
      onFail?.call("Erro inesperado: $e");

      loadingGoogle = false;
    }

    PerformanceMonitoring().stopTrace('login-google');
  }

  Future<void> _updateMonthlyNewUsers() async {
    if (!_newUserAccount || users == null) return;

    final now = DateTime.now();

    final monthKey =
        "${now.year}-${now.month.toString().padLeft(2, '0')}";

    final doc = await _firestoreService.getDocument(
      collection: "monthly",
      docId: monthKey,
    );

    if (doc.exists) {
      await _firestoreService.updateDocument(
        collection: "monthly",
        docId: monthKey,
        data: {
          'count': FieldValue.increment(1),
        },
      );
    } else {
      await _firestoreService.setDocument(
        collection: "monthly",
        docId: monthKey,
        data: {
          'count': 1,
        },
      );
    }

    _newUserAccount = false;
  }

// TODO(BRN): UserManager ainda concentra autenticação,
// estado do usuário e gerenciamento de perfil.

// TODO: Criação de método para capturar cookies e dados do Analytics
/* Future<void> _loadUserVisitor ({User? user}) async {

} */
}