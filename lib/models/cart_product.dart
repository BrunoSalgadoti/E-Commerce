import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:ecommerce/models/product.dart';

class CartProduct {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? productId;
  int? quantity;
  String? size;
  
  Product? product;

  CartProduct.fromProduct(this.product) {
    productId = product!.id;
    quantity = 1;
    size = product!.selectedDetails?.size;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;
    
    firestore.doc('products/$productId').get().then(
            (doc) => product = Product.fromDocument(doc)
    );
  }

  DetailsProducts? get detailsProducts {
    if(product == null) return null;
    return product!.findSize(size!);
  }
  num get unitPrice {
    if(product == null) return 0;
    return detailsProducts?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedDetails!.size == size;
  }
}