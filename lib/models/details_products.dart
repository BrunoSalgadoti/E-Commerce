class DetailsProducts {

  DetailsProducts();

  DetailsProducts.fromMap(Map<String, dynamic> map) {
        size = map['size'] as String;
        price = map['price'] as num;
        stock =  map['stock'] as int;
  }

  String? size;
  num? price;
  int stock = 0;

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'DetailsProducts{size: $size, price: $price, stock: $stock}';
  }
}