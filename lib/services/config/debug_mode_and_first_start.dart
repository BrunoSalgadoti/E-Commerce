import 'package:brn_ecommerce/models/categories_of_products/product_category_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Executa operações específicas durante o modo de depuração e no primeiro início do aplicativo.
///
/// Esta função é projetada para ser usada durante o desenvolvimento do aplicativo.
/// Ela executa operações que podem ser úteis apenas no ambiente de depuração,
/// como a atualização das informações de versão e a criação de tabelas auxiliares.
///
/// [firstStart] - Indica se é o primeiro início do aplicativo.
Future<void> debugModeAndFirstStart({required bool firstStart}) async {
  if (!kReleaseMode) {
    /// Atualiza as informações de versão do aplicativo.
    // This code snippet will only run in debug mode
    final versionManager = VersionManager();
    await versionManager.updateVersionInfo();

    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError =
        FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    ///Exemple of make a first error: for testing framework to Crashlytics:
    // TextButton(
    //   onPressed: () => throw Exception(),
    //   child: const Text("Throw Test Exception"),
    // );

    ///Criação de Tabelas Auxiliares
    ///
    /// Nesta parte do código, tabelas auxiliares, como tabelas de vendas e tabelas de
    /// administração, são criadas durante o primeiro início do aplicativo. Essas tabelas
    /// podem ser usadas para funcionalidades específicas do aplicativo e são definidas
    /// pelo desenvolvedor.
    ///
    /// IMPORTANTE: Essa parte do código deve ser executada com cuidado, pois cria tabelas
    /// no Firestore que não são modificadas diretamente pelos usuários. Modificações
    /// posteriores nessas tabelas devem ser feitas apenas pelo desenvolvedor, levando em
    /// consideração o impacto nas funcionalidades do aplicativo.

    /// Cria tabelas auxiliares de usuários e administradores se não existirem
    /// durante o primeiro início do aplicativo.
    /// CASO:  [firstStart = true] - no main.dart.
    // This code snippet will only run in debug mode and case [firstStart = true]
    // - in main.dart
    UserManager().createAuxAndAdminsIfNotExists(firstStart: firstStart);

    /// Cria ou atualiza as categorias de produtos no Firestore durante o primeiro início
    /// do aplicativo ou expressamente solicitado pelo Dono da Loja Virtual.
    /// CASO:  [firstStart = true] - no main.dart.
    // This code snippet will only run in debug mode and case [firstStart = true]
    // - in main.dart
    ProductCategoryManager()
        .createProductCategoriesIfNotExists(firstStart: firstStart);
  }
}
