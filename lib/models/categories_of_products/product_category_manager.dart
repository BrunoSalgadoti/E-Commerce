import 'dart:async';

import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../helpers/product_categories_factory_lists/categories_factory.dart';

class ProductCategoryManager extends ChangeNotifier {
  ProductCategoryManager() {
    verifyUser(userManager ?? UserManager());
  }

  UserManager? userManager;

  List<ProductCategory> _categoriesList = [];

  StreamSubscription<QuerySnapshot>? _categoriesListener;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool verifyCategoriesList() {
    if (_categoriesList.isEmpty) return true;
    return false;
  }

  Future<void> updateCategory() async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Update Category to Firebase');
    }

    final categoriesQuery = await firestore.collection("categories").get();

    for (final category in _categoriesList) {
      // Check if the category already exists in the database
      final categoryRef = categoriesQuery.docs
          .firstWhere((doc) => doc.id == category.categoryID);

      // If it exists, check if any attributes are different and update
      final data = category.toMap();
      final dbData = categoryRef.data();

      if (!mapEquals(data, dbData)) {
        await firestore
            .collection("categories")
            .doc(category.categoryID)
            .update(data);
      }
    }
  }

  /// Esta função verifica o tipo de usuário e carrega as categorias correspondentes.
  ///
  /// Se o usuário for um administrador (adminEnable == true), ela carrega todas as
  /// categorias e configura a escuta em tempo real para atualizações nas categorias.
  /// Isso garante que os administradores tenham acesso a todas as categorias, independentemente
  /// do status de ativação da categoria.
  ///
  /// Se o usuário não for um administrador (adminEnable == false), ela carrega apenas
  /// as categorias ativas (categoryActivated == true) e configura a escuta em tempo real
  /// para atualizações nessas categorias. Isso economiza recursos, pois os usuários regulares
  /// não precisam carregar todas as categorias.
  ///
  /// [userManager] é uma instância de [UserManager] que contém informações sobre o usuário.
  Future<void> verifyUser(UserManager userManager) async {
    _categoriesListener?.cancel();
    _categoriesList.clear();
    if (userManager.adminEnable) {
      _loadAllCategories();
      _setupRealTimeUpdatesAllCategories();
      notifyListeners();
    } else if (!userManager.adminEnable) {
      _categoriesList.clear();
      _loadCategoriesForUsers();
      notifyListeners();
    }
  }

  Future<void> _loadCategoriesForUsers() async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info _loadCategoriesForUSERS');
    }
    // Starts trying to get data from cache
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("categories")
        .where("categoryActivated", isEqualTo: true)
        .get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      _categoriesList = snapshot.docs
          .map((category) => ProductCategory.fromDocument(category))
          .toList();
      notifyListeners();
    }

    // Configure real-time update listener for Users
    _categoriesListener = firestore
        .collection("categories")
        .where("categoryActivated", isEqualTo: true)
        .snapshots()
        .listen((event) {
      _categoriesList =
          event.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    });
  }

  Future<void> _loadAllCategories() async {
    PerformanceMonitoring()
        .startTrace('_loadCategoriesList', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info _loadAllCategories');
    }

    // Starts trying to get data from cache
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("categories")
        .get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      _categoriesList =
          snapshot.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    }

    PerformanceMonitoring().stopTrace('_loadCategoriesList');
  }

  Future<void> _setupRealTimeUpdatesAllCategories() async {
    PerformanceMonitoring()
        .startTrace('setup-rt-updates-categories', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: _categoriesListener Start ');
    }

    // Configure real-time update listener
    _categoriesListener =
        firestore.collection("categories").snapshots().listen((event) {
      _categoriesList =
          event.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('setup-rt-updates-categories');
  }

  List<ProductCategory> filterCategoriesActivated(
      bool adminEnable, bool editingCategories) {
    final List<ProductCategory> categoriesActive = [];

    if (adminEnable == true && editingCategories == true) {
      categoriesActive.addAll(_categoriesList.toList()
        ..sort((a, b) => a.categoryTitle!.compareTo(b.categoryTitle!)));
    } else {
      categoriesActive.addAll(_categoriesList
          .where((category) => category.categoryActivated!)
          .toList()
        ..sort((a, b) => a.categoryTitle!.compareTo(b.categoryTitle!)));
    }

    return categoriesActive;
  }

  /// Esta função é usada para criar ou atualizar categorias de produtos no Firestore,
  /// dependendo das condições especificadas.
  ///
  /// [firstStart]: Indica se é a primeira inicialização da loja ou pode ser
  /// ativado para atualização das categorias, com autorização expressa do Dono da Loja.
  ///
  /// Se [firstStart] for verdadeiro, a função verificará o estado atual da coleção
  /// "categories" no Firestore e tomará as seguintes ações:
  ///
  /// - Se a coleção estiver vazia ou seu tamanho for diferente do tamanho da lista de
  ///   categorias de fábrica [categoriesFactoryList], a função criará categorias no Firestore
  ///   com base na lista de fábrica para garantir que todas as categorias estejam presentes.
  ///
  /// - Se a coleção no Firestore for maior que a lista de fábrica, a função apagará as
  ///   categorias excedentes no Firestore que não estão na lista de fábrica.
  ///
  /// - Se uma categoria já existir no Firestore, a função verificará se algum atributo
  ///   é diferente e atualizará os dados no Firestore para corresponder à lista de fábrica.
  ///
  /// Esta função é destinada a uso administrativo e deve ser chamada apenas quando necessário,
  /// como parte da configuração inicial da loja ou atualização requerida pelo Dono Da Loja.
  /// Certifique-se de entender bem seu comportamento antes de usá-la, pois ela pode afetar
  /// as categorias no Firestore.
  Future<void> createProductCategoriesIfNotExists(
      {required bool firstStart}) async {
    if (!kReleaseMode && firstStart == true) {
      MonitoringLogger().logInfo('Info: Creating Categories');

      // Check if "categories" collection is empty in Firebase
      final categoriesQuery = await firestore.collection("categories").get();

      if (categoriesQuery.docs.isEmpty ||
          categoriesQuery.docs.length != categoriesFactoryList.length) {
        // If it is empty or smaller than the factory list,
        // create categories or insert new categories from the factory list
        for (final category in categoriesFactoryList) {
          final categoryID = category.categoryID;
          final categoryExists =
              categoriesQuery.docs.any((doc) => doc.id == categoryID);

          if (!categoryExists) {
            await firestore
                .collection("categories")
                .doc(category.categoryID)
                .set(category.toMap());
          }
          // deletes fiestore categories if the factory list is smaller than
          // the firebase list
          if (categoriesQuery.docs.length > categoriesFactoryList.length) {
            final docsToDelete = categoriesQuery.docs.where(
              (doc) => !categoriesFactoryList
                  .any((category) => category.categoryID == doc.id),
            );

            for (final docToDelete in docsToDelete) {
              await firestore
                  .collection("categories")
                  .doc(docToDelete.id)
                  .delete();
            }
          }
        }
      } else {
        for (final category in categoriesFactoryList) {
          // Check if the category already exists in the database
          final categoryRef = categoriesQuery.docs
              .firstWhere((doc) => doc.id == category.categoryID);

          // If it exists, check if any attributes are different and update
          final data = category.toMap();
          final dbData = categoryRef.data();

          // Check and update only missing fields
          data.forEach((key, value) {
            if (!dbData.containsKey(key)) {
              dbData[key] = value;
            }
          });

          // Update the Firestore document with the merged data
          await categoryRef.reference.set(dbData);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _categoriesListener?.cancel();
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info: ListenerCancel ');
    }
  }
}
