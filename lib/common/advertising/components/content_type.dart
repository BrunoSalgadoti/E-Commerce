import 'package:brn_ecommerce/models/product.dart';

enum ContentType {
  productCard,
  image16x9,
}

class AdvertisingCarouselContent {
  final ContentType type;
  final Product? product; //Maybe null if it is an image
  final String? imageUrl; //Maybe null if it is a card

  AdvertisingCarouselContent({
    required this.type,
    this.product,
    this.imageUrl,
  });
}
