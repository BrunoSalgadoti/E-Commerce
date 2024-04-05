/// # Subcategory model for products (Folder: models/products/product_category)
/// ## SubCategory
/// A class representing a subcategory of products.
///
/// This class encapsulates information about a subcategory, including its ID, title, icon,
/// and associated product ID.
class SubCategory {
  String? subCategoryID;
  String? subCategoryTitle;
  String? iconSubCategories;
  String? productID;

  /// Creates a [SubCategory] with the specified parameters.
  ///
  /// The [subCategoryID], [subCategoryTitle], [iconSubCategories], and [productID] parameters are optional and default to `null`.
  SubCategory({this.subCategoryID, this.subCategoryTitle, this.iconSubCategories, this.productID});

  /// Creates a [SubCategory] from a map of data.
  ///
  /// The map should contain keys corresponding to the properties of a [SubCategory].
  SubCategory.fromMap(Map<String, dynamic> map) {
    subCategoryID = map["subCategoryID"] as String? ?? "";
    subCategoryTitle = map["subCategoryTitle"] as String? ?? "";
    iconSubCategories = map["iconSubCategories"] as String? ?? "";
    productID = map["productID"] as String? ?? "";
  }

  /// Converts this [SubCategory] instance to a map.
  ///
  /// Returns a map representation of the subcategory, suitable for storing in Firestore or similar databases.
  Map<String, dynamic> toMap() {
    return {
      "subCategoryID": subCategoryID,
      "subCategoryTitle": subCategoryTitle,
      "iconSubCategories": iconSubCategories,
      "productID": productID,
    };
  }
}
