/// # SectionItem (Folder: models/views)
///
/// A class representing an item in a section.
class SectionItem {
  // Proprieties

  String? product;
  dynamic image;

  /// Constructor for SectionItem.
  ///
  /// [image] can be a String representing a URL or a File object.
  /// [product] is the name or description of the item.
  SectionItem({this.image, this.product});

  /// Constructor from Map.
  ///
  /// Constructs a SectionItem object from a map.
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map["image"] as String;
    product = map["product"] as String?;
  }

  // Methods

  /// Converts SectionItem to Map.
  ///
  /// Returns a map representation of the SectionItem object.
  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "product": product,
    };
  }

  /// Clones the SectionItem.
  ///
  /// Returns a new SectionItem object with the same image and product values.
  SectionItem clone() {
    return SectionItem(image: image, product: product);
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}
