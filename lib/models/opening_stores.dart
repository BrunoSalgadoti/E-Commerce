class OpeningStores {
  OpeningStores({
    this.monFri,
    this.saturday,
    this.monday,
  });

  OpeningStores.fromMap(Map<String, dynamic> map) {
    monFri = map["monFri"] as String? ?? "";
    saturday = map["saturday"] as String? ?? "";
    monday = map["monday"] as String? ?? "";
  }

  String? monFri;
  String? saturday;
  String? monday;

  Map<String, dynamic> toMap() {
    return {
      "monFri": monFri,
      "saturday": saturday,
      "monday": monday,
    };
  }
}
