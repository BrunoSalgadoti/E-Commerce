import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/sales/delivery.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/db_api/config.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


/// # UserManager (Folder: models/users)
///
/// A class responsible for managing user authentication and data related to user accounts.
///
/// This class handles sign-in, sign-up, user data retrieval, and other related operations.
class UserManager extends ChangeNotifier {
  // Proprieties of Users

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;
  bool _newUserAccount = false;
  bool _editingCategories = false;
  bool _loadingFace = false;
  bool _loadingGoogle = false;
  Users? users;

  // Constructor

  /// Initializes a [UserManager] instance.
  UserManager() {
    if (isLoggedIn || _newUserAccount == true) {
      _loadCurrentUser();
    }
    _auth.setLanguageCode('pt-BR');
  }

  // Getters and Setters

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

  // Methods

  /// Checks if necessary auxiliary documents and admin data exist in Firestore.
  Future<void> createAuxAndAdminsIfNotExists({required bool firstStart}) async {
    if (kDebugMode && firstStart == true) {
      MonitoringLogger().logInfo('Info: Verifier createAuxAndAdminsIfNotExists');

      // Check if the "admins" collection is empty
      final adminsQuery = await firestore.collection("admins").limit(1).get();
      final usersQuery = await firestore.collection("users").get();
      if (adminsQuery.docs.isEmpty && usersQuery.docs.isNotEmpty) {
        // Create document '{users.id}' in collection 'admins' with user id as admin
        await firestore.collection("admins").doc(users!.id).set({
          "user": users!.id,
        });
        users!.admin = true; // Set user as administrator on first login
      }

      // Check if the "aux" collection contains the "delivery" document
      final deliveryDoc = firestore.collection("aux").doc("delivery");
      final doc = await deliveryDoc.get();
      if (!doc.exists) {
        final delivery = Delivery(); // Create a new instance of the Delivery class
        await deliveryDoc.set(delivery.toMap());
      }

      // Check if the "aux" collection contains the "orderCounter" document
      final orderCounterDoc = firestore.collection("aux").doc("orderCounter");
      final orderCounterDocExists = await orderCounterDoc.get();
      if (!orderCounterDocExists.exists) {
        // Create the "orderCounter" document with "current" field set to 1
        await orderCounterDoc.set({"current": 1});
      }
    }
  }

  /// Signs in with email and password.
  Future<void> signInWithEmailAndPassword(
      {required Users users, required Function onFail, required Function onSuccess}) async {
    PerformanceMonitoring().startTrace('sign-in-email', shouldStart: true);

    _newUserAccount = true;
    loading = true;
    try {
      final UserCredential result =
      await _auth.signInWithEmailAndPassword(email: users.email, password: users.password!);

      await _loadCurrentUser(user: result.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
    PerformanceMonitoring().stopTrace('sign-in-email');
  }

  /// Signs in or signs up with Facebook authentication.
  Future<void> loginOrSingUpWithFacebook(
      {required Function? onFail, required Function? onSuccess}) async {
    PerformanceMonitoring().startTrace('login-facebook', shouldStart: true);

    try {
      loadingFace = true;
      // check if is running on Web
      if (kIsWeb) {
        await FacebookAuth.i.webAndDesktopInitialize(
          appId: Config.facebookAppId,
          cookie: true,
          xfbml: true,
          version: "v17.0",
        );
      }

      // Realize authentication for the Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
        // Gets the user's access token
          final AccessToken accessToken = result.accessToken!;

          // Converte o token de acesso em uma credencial do Firebase
          final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.tokenString);

          // Converts the access token to a Firebase credential
          final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

          // Get authenticated user
          final User? user = userCredential.user;

          if (user != null) {
            // Check if the user document already exists in Firestore
            final DocumentSnapshot userSnapshot =
            await firestore.collection("users").doc(user.uid).get();

            // Capture user data and save to FirebaseFirestore
            if (userSnapshot.exists) {
              users = Users.fromDocument(userSnapshot);
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
            }
          }

          loadingFace = false;
          onSuccess!();
          break;
        case LoginStatus.failed:
          onFail!("Erro ao Logar com Facebook! ${result.status}");
          loadingFace = false;
          break;
        case LoginStatus.cancelled:
          onFail!("Login cancelado pelo Usuário! ${result.status}");
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

  /// Signs in or signs up with Google authentication.
  Future<void> loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
  }) async {
    PerformanceMonitoring().startTrace('login-google', shouldStart: true);

    try {
      loadingGoogle = true;

      if (kIsWeb) {
        // Login via redirect no Web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        await FirebaseAuth.instance.signInWithRedirect(googleProvider);
        return;
      }

      // Inicializa o GoogleSignIn (novo formato v7+)
      await GoogleSignIn.instance.initialize();

      // Login do usuário
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn.instance.authenticate();

      if (googleUser == null) {
        onFail?.call("Login cancelado pelo usuário!");
        loadingGoogle = false;
        return;
      }

      // Obter autenticação
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Criar credencial para o Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userSnapshot =
        await firestore.collection("users").doc(user.uid).get();

        if (userSnapshot.exists) {
          users = Users.fromDocument(userSnapshot);
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

  /* Future<void> loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
  }) async {
    PerformanceMonitoring().startTrace('login-google', shouldStart: true);

    try {
      loadingGoogle = true;

      if (kIsWeb) {
        // Login via redirect no Web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        await FirebaseAuth.instance.signInWithRedirect(googleProvider);
        return;
      }

      // Instância do GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Usuário cancelou o login
        onFail?.call("Login cancelado pelo usuário!");
        loadingGoogle = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userSnapshot =
        await firestore.collection("users").doc(user.uid).get();

        if (userSnapshot.exists) {
          users = Users.fromDocument(userSnapshot);
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
  } */

  /// Signs up with email and password.
  Future<void> singUpWithEmailAndPassword(
      {required Users users, required Function onFail, required Function onSuccess}) async {
    PerformanceMonitoring().startTrace('sing-up-email', shouldStart: true);

    loading = true;

    try {
      final UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: users.email, password: users.password!);

      users.id = result.user!.uid;
      users.policyAndTerms = true;
      this.users = users;

      await users.saveUserData();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;

    PerformanceMonitoring().stopTrace('sing-up-email');
  }

  /// Signs out the current user.
  void signOut() {
    _auth.signOut();
    users = null;
    notifyListeners();
  }

  /// Loads the current user's data from Firestore.
  Future<void> _loadCurrentUser({User? user}) async {
    try {
      final User currentUser = user ?? _auth.currentUser!;
      if (currentUser.uid.isNotEmpty) {
        final DocumentSnapshot docUsers =
        await firestore.collection("users").doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);

        final docAdmin = await firestore.collection("admins").doc(users?.id).get();
        if (docAdmin.exists) {
          users?.admin = true;
        }
        notifyListeners();
      }
    } catch (error) {
      reportNoFatalErrorToCrashlytics(
          error: "$error",
          stackTrace: StackTrace.current,
          information: "Erro na Classe: UserManager no método _loadCurrentUser()");
      MonitoringLogger().logError('Erro ao carregar CurrentUser: $error');
    }
    notifyListeners();
  }

//TODO: Criação de método para capturar cookies e dados do Analytics
// Future<void> _loadUserVisitor ({User? user}) async {
//
// }
}
