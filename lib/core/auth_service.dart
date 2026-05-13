import 'package:brn_ecommerce/core/control_center.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._internal();

  static final AuthService instance = AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ControlCenter _control = ControlCenter.instance;

  final MonitoringLogger _logger = MonitoringLogger();

  User? get currentUser => _auth.currentUser;

  Future<void> setLanguageCode(String languageCode) async {
    await _auth.setLanguageCode(languageCode);
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → signIn');

      throw Exception('Auth blocked');
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    _control.registerUsage(OperationType.auth);

    return result;
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → signUp');

      throw Exception('Auth blocked');
    }

    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    _control.registerUsage(OperationType.auth);

    return result;
  }

  Future<UserCredential> signInWithCredential(
      AuthCredential credential,
      ) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → signInWithCredential');

      throw Exception('Auth blocked');
    }

    final result = await _auth.signInWithCredential(
      credential,
    );

    _control.registerUsage(OperationType.auth);

    return result;
  }

  Future<void> signInWithRedirect(
      AuthProvider provider,
      ) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → signInWithRedirect');

      throw Exception('Auth blocked');
    }

    await _auth.signInWithRedirect(provider);

    _control.registerUsage(OperationType.auth);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordReset({
    required String email,
    ActionCodeSettings? actionCodeSettings,
  }) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → sendPasswordReset');

      throw Exception('Auth blocked');
    }

    await _auth.sendPasswordResetEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    _control.registerUsage(OperationType.auth);
  }

  Future<void> checkActionCode(String code) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → checkActionCode');

      throw Exception('Auth blocked');
    }

    await _auth.checkActionCode(code);

    _control.registerUsage(OperationType.auth);
  }

  Future<void> applyActionCode(String code) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → applyActionCode');

      throw Exception('Auth blocked');
    }

    await _auth.applyActionCode(code);

    _control.registerUsage(OperationType.auth);
  }

  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    if (!_control.canExecute(OperationType.auth)) {
      _logger.logWarning('AUTH BLOCKED → confirmPasswordReset');

      throw Exception('Auth blocked');
    }

    await _auth.confirmPasswordReset(
      code: code,
      newPassword: newPassword,
    );

    _control.registerUsage(OperationType.auth);
  }

// TODO(BRN): avaliar controle separado para
// OAuth providers (Google/Facebook/Apple)
// caso seja necessário monitoramento granular.
}