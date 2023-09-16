import 'package:brn_ecommerce/models/product_category.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../helpers/product_categories_factory_lists/categories_factory.dart';

class ProductCategoryManager extends ChangeNotifier {
  ProductCategoryManager({this.categoriesList}) {
    categoriesList = categoriesList ?? [];
  }

  List<ProductCategory>? categoriesList;

  ProductCategory? categories;

  ProductCategory? get categoriesChanges => categories;

  set categoriesChanges(ProductCategory? value) {
    categories = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
          if (categoriesQuery.docs.length < categoriesFactoryList.length) {
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

          if (!mapEquals(data, dbData)) {
            await firestore
                .collection("categories")
                .doc(category.categoryID)
                .update(data);
          }
        }
      }
    }
  }

//
// Future<List<ProductCategory>> getCategoriesFromDB() async {
//   // Lógica para obter as categorias atualizadas do banco de dados
//   // Isso pode incluir uma chamada a um serviço ou consulta a um banco de dados
//   // Retorne uma lista de categorias atualizadas
// }

// void updateCategory({
//   Color? categoryColor,
//   String? categoryImg,
//   bool? categoryActivated,
// }) {
//   if (categoryColor != null) {
//     this.categoryColor = categoryColor;
//   }
//   if (categoryImg != null) {
//     this.categoryImg = categoryImg;
//   }
//   if (categoryActivated != null) {
//     this.categoryActivated = categoryActivated;
//   }
//   // Notificar os ouvintes de que a categoria foi atualizada
//   notifyListeners();
// }

//   // Suponha que você tenha obtido as informações do banco de dados em updatedCategories
//   final updatedCategories = await getCategoriesFromDB();
//
// // Percorra as categorias atualizadas e atualize as propriedades individuais
//   for (final updatedCategory in updatedCategories) {
//   final existingCategory = productCategoryLists.categoriesList.firstWhere(
//   (category) => category.categoryID == updatedCategory.categoryID,
//   orElse: () => null,
//   );
//
//   if (existingCategory != null) {
//   // Atualize apenas as propriedades que você deseja modificar
//   existingCategory.categoryTitle = updatedCategory.categoryTitle;
//   existingCategory.categoryColor = updatedCategory.categoryColor;
//   // Adicione outras propriedades que deseja atualizar
//   }
//   }

//   void updateCategoryColor(Color newColor) {
//     categoryColor = newColor;
//     notifyListeners(); // Notificar os ouvintes sobre a mudança.
//   }
// }
}
