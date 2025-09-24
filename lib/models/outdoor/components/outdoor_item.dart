enum OutdoorType { image, asset, youtube }

class OutdoorItem {
  final String id;
  final String url;
  final OutdoorType type;

  OutdoorItem({
    required this.id,
    required this.url,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type.name,
    };
  }

  factory OutdoorItem.fromMap(String id, Map<String, dynamic> map) {
    return OutdoorItem(
      id: id,
      url: map['url'] ?? '',
      type: OutdoorType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => OutdoorType.image,
      ),
    );
  }
}
