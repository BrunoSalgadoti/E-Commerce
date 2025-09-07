import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';

class AppLinkHandler {
  final GlobalKey<NavigatorState> navigatorKey;
  final UserManager userManager;

  StreamSubscription<Uri>? _linkSubscription;
  Uri? _lastHandledUri;

  AppLinkHandler({required this.navigatorKey, required this.userManager});

  /// Initializes deep link capture
  Future<void> init() async {
    final appLinks = AppLinks();

    // 1️⃣ Captures initial link if the app is opened via link
    try {
      final initialUri = await appLinks.getInitialLink();
      if (initialUri != null) {
        _handleUri(initialUri);
      }
    } catch (e) {
      debugPrint('Erro ao capturar link inicial: $e');
    }

    // 2️⃣ Listens for incoming links while the app is open
    _linkSubscription = appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (err) => debugPrint('Erro no stream de links: $err'),
    );
  }

  /// Handles the received URI
  void _handleUri(Uri uri) {
    // Avoids duplicate processing
    if (_lastHandledUri != null && _lastHandledUri == uri) {
      debugPrint('Link já tratado: $uri');
      return;
    }

    debugPrint('Recebido link: $uri');
    debugPrint('Query Parameters: ${uri.queryParameters}');

    final mode = uri.queryParameters['mode'];
    final oobCode = uri.queryParameters['oobCode'];

    if (uri.host == "login") {
      // 🔑 Deep link directly to login screen
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        RoutesNavigator.loginScreen,
        (route) => false,
      );
    } else if (mode != null && oobCode != null) {
      switch (mode) {
        case 'resetPassword':
          navigatorKey.currentState?.pushNamed(
            RoutesNavigator.resetPasswordScreen,
            arguments: {'oobCode': oobCode},
          );
          break;

        case 'verifyEmail':
          userManager.verifyEmailWithCode(
            navigatorKey.currentContext!,
            oobCode,
          );
          break;

        default:
          debugPrint('Modo desconhecido no deep link: $mode');
          return;
      }
    } else {
      debugPrint('Link inválido ou não suportado: $uri');
      return;
    }

    _lastHandledUri = uri;
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
