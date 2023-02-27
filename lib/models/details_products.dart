class DetailsProducts {

  DetailsProducts.fromMap(Map<String, dynamic> map) {
        size = map['size'] as String;
        price = map['price'] as num;
        stock =  map['stock'] as int;
  }

  String size = '';
  num price = 0.0;
  int stock = 0;

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'DetailsProducts{size: $size, price: $price, stock: $stock}';
  }
}