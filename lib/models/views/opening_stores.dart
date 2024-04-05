/// # OpeningStores (Folder: models/views)
///
/// A class representing the opening hours of stores for different days.
///
/// This class provides methods to convert data to and from a map for Firestore storage.
class OpeningStores {
  // Proprieties

  String? monFri;
  String? saturday;
  String? monday;

  // Constructor

  /// Initializes an [OpeningStores] instance with optional opening hours for different days.
  OpeningStores({
    this.monFri,
    this.saturday,
    this.monday,
  });

  // Methods

  /// Creates an [OpeningStores] instance from a map of opening hours data.
  OpeningStores.fromMap(Map<String, dynamic> map) {
    monFri = map["monFri"] as String? ?? "";
    saturday = map["saturday"] as String? ?? "";
    monday = map["monday"] as String? ?? "";
  }

  /// Converts the [OpeningStores] instance to a map for storage in Firestore.
  Map<String, dynamic> toMap() {
    return {
      "monFri": monFri,
      "saturday": saturday,
      "monday": monday,
    };
  }
}
