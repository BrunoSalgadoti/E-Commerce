class SubCategory {
  SubCategory(
      {this.subCategoryID,
      this.subCategoryTitle,
      this.iconSubCategories,
      this.productID});

  String? subCategoryID;
  String? subCategoryTitle;
  String? iconSubCategories;
  String? productID;

  SubCategory.fromMap(Map<String, dynamic> map) {
    subCategoryID = map["subCategoryID"] as String? ?? "";
    subCategoryTitle = map["subCategoryTitle"] as String? ?? "";
    iconSubCategories = map["iconSubCategories"] as String? ?? "";
    productID = map["productID"] as String? ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      "subCategoryID": subCategoryID,
      "subCategoryTitle": subCategoryTitle,
      "iconSubCategories": iconSubCategories,
      "productID": productID,
    };
  }

//TODO: Verificar implementação
// SubCategory cloneSubCategory() {
//   return SubCategory(
//     subCategoryID: subCategoryID,
//     subCategoryTitle: subCategoryTitle,
//     iconSubCategories: iconSubCategories,
//     productID: productID,
//   );
// }
}
