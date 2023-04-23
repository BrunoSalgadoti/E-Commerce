class DetailsProducts {
  DetailsProducts({this.size, this.price, required this.stock});

  DetailsProducts.fromMap(Map<String, dynamic> map) {
    size = map['size'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String? size;
  num? price;
  int stock = 0;

  bool get hasStock => stock > 0;

  DetailsProducts clone() {
    return DetailsProducts(
      size: size,
      price: price,
      stock: stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'price': price,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'DetailsProducts{size: $size, price: $price, stock: $stock}';
  }
}
