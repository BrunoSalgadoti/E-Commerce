import 'dart:async';

import 'package:brn_ecommerce/helpers/product_categories_factory_lists/categories_factory.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # Manager for handling product categories (Folder: models/products/product_category)
/// ## ProductCategoryManager
/// A class responsible for managing product categories, including updating and filtering operations.
///
/// This manager handles the logic related to product categories, such as updating categories in Firebase,
/// loading categories for users, configuring real-time updates for categories, and filtering activated categories.
class ProductCategoryManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserManager? userManager;
  List<ProductCategory> _categoriesList = [];
  StreamSubscription<QuerySnapshot>? _categoriesListener;

  //Constructor

  ProductCategoryManager() {
    verifyUser(userManager ?? UserManager());
  }

  /// Verifies if the categories list is empty.
  ///
  /// Returns `true` if the list is empty; otherwise, returns `false`.
  bool verifyCategoriesList() {
    if (_categoriesList.isEmpty) return true;
    return false;
  }

  /// Updates the categories in Firebase based on the local data.
  ///
  /// This method retrieves the categories from Firestore, compares them with the local data, and updates
  /// any differences to ensure consistency between the app and the database.
  Future<void> updateCategory() async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Update Category to Firebase');
    }

    final categoriesQuery = await firestore.collection("categories").get();

    for (final category in _categoriesList) {
      // Check if the category already exists in the database
      final categoryRef = categoriesQuery.docs.firstWhere((doc) => doc.id == category.categoryID);

      // If it exists, check if any attributes are different and update
      final data = category.toMap();
      final dbData = categoryRef.data();

      if (!mapEquals(data, dbData)) {
        await firestore.collection("categories").doc(category.categoryID).update(data);
      }
    }
  }

  /// This function checks the user type and loads the corresponding categories.
  ///
  /// If the user is an administrator (adminEnable == true), it loads all
  /// categories and configures real-time listening for updates on categories.
  /// This ensures that administrators have access to all categories, regardless of
  /// of the category activation status.
  ///
  /// If the user is not an administrator (adminEnable == false), it only loads
  /// the active categories (categoryActivated == true) and configure real-time listening
  /// for updates in these categories. This saves resources as regular users
  /// do not need to load all categories.
  ///
  /// [userManager] is an instance of [UserManager] that contains information about the user.
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

  /// Loads activated categories for users from Firestore.
  ///
  /// This method retrieves activated categories from Firestore and updates the local categories list accordingly.
  Future<void> _loadCategoriesForUsers() async {
    if (kDebugMode) {
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
      _categoriesList =
          snapshot.docs.map((category) => ProductCategory.fromDocument(category)).toList();
      notifyListeners();
    }

    // Configure real-time update listener for Users
    _categoriesListener = firestore
        .collection("categories")
        .where("categoryActivated", isEqualTo: true)
        .snapshots()
        .listen((event) {
      _categoriesList = event.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    });
  }

  // Loads all categories from Firestore.
  ///
  /// This method retrieves all categories from Firestore, including both activated and deactivated categories.
  Future<void> _loadAllCategories() async {
    PerformanceMonitoring().startTrace('_loadCategoriesList', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info _loadAllCategories');
    }

    // Starts trying to get data from cache
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("categories").get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      _categoriesList = snapshot.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    }

    PerformanceMonitoring().stopTrace('_loadCategoriesList');
  }

  /// Sets up real-time updates for all categories from Firestore.
  ///
  /// This method configures a listener for real-time updates on categories in Firestore and updates the
  /// local categories list whenever changes occur.
  Future<void> _setupRealTimeUpdatesAllCategories() async {
    PerformanceMonitoring().startTrace('setup-rt-updates-categories', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: _categoriesListener Start ');
    }

    // Configure real-time update listener
    _categoriesListener = firestore.collection("categories").snapshots().listen((event) {
      _categoriesList = event.docs.map((s) => ProductCategory.fromDocument(s)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('setup-rt-updates-categories');
  }

  /// Filters and retrieves activated categories based on admin privileges and editing mode.
  ///
  /// This method filters the list of categories based on whether the user has admin privileges and whether
  /// they are in the process of editing categories.
  ///
  /// - If `adminEnable` is `true` and `editingCategories` is `true`, all categories are returned.
  /// - If `adminEnable` is `false`, only activated categories are returned.
  ///
  /// The returned list is sorted alphabetically by category title.
  List<ProductCategory> filterCategoriesActivated(bool adminEnable, bool editingCategories) {
    final List<ProductCategory> categoriesActive = [];

    if (adminEnable == true && editingCategories == true) {
      categoriesActive.addAll(
          _categoriesList.toList()..sort((a, b) => a.categoryTitle!.compareTo(b.categoryTitle!)));
    } else {
      categoriesActive.addAll(
          _categoriesList.where((category) => category.categoryActivated!).toList()
            ..sort((a, b) => a.categoryTitle!.compareTo(b.categoryTitle!)));
    }

    return categoriesActive;
  }

  /// This function is used to create or update product categories in Firestore,
  /// depending on the specified conditions.
  ///
  /// [firstStart]: Indicates whether this is the store's first startup or it can be
  /// activated to update categories, with express authorization from the Store Owner.
  ///
  /// If [firstStart] is true, the function will check the current state of the collection
  /// "categories" in Firestore and will take the following actions:
  ///
  /// - If the collection is empty or its size is different from the size of the list of
  /// factory categories [categoriesFactoryList], the function will create categories in Firestore
  /// based on the factory list to ensure all categories are present.
  ///
  /// - If the collection in Firestore is larger than the factory list, the function will delete the
  /// surplus categories in Firestore that are not in the factory list.
  ///
  /// - If a category already exists in Firestore, the function will check if any attributes
  /// is different and will update the data in Firestore to match the factory list.
  ///
  /// This function is intended for administrative use and should only be called when necessary,
  /// as part of the initial store setup or update required by the Store Owner.
  /// Make sure you understand its behavior well before using it, as it may affect
  /// the categories in Firestore.
  Future<void> createProductCategoriesIfNotExists({required bool firstStart}) async {
    if (kDebugMode && firstStart == true) {
      MonitoringLogger().logInfo('Info: Creating Categories');

      // Check if "categories" collection is empty in Firebase
      final categoriesQuery = await firestore.collection("categories").get();

      if (categoriesQuery.docs.isEmpty ||
          categoriesQuery.docs.length != categoriesFactoryList.length) {
        // If it is empty or smaller than the factory list,
        // create categories or insert new categories from the factory list
        for (final category in categoriesFactoryList) {
          final categoryID = category.categoryID;
          final categoryExists = categoriesQuery.docs.any((doc) => doc.id == categoryID);

          if (!categoryExists) {
            await firestore.collection("categories").doc(category.categoryID).set(category.toMap());
          }
          // deletes firestore categories if the factory list is smaller than
          // the firebase list
          if (categoriesQuery.docs.length > categoriesFactoryList.length) {
            final docsToDelete = categoriesQuery.docs.where(
              (doc) => !categoriesFactoryList.any((category) => category.categoryID == doc.id),
            );

            for (final docToDelete in docsToDelete) {
              await firestore.collection("categories").doc(docToDelete.id).delete();
            }
          }
        }
      } else {
        for (final category in categoriesFactoryList) {
          // Check if the category already exists in the database
          final categoryRef =
              categoriesQuery.docs.firstWhere((doc) => doc.id == category.categoryID);

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
    _categoriesListener?.cancel();
    super.dispose();
  }
}
