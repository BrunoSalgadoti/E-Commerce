import 'package:brn_ecommerce/models/products/product.dart';

/// ## AdvertisingCarouselContent (Folder: common/advertising/components)
/// ### Components of Advertising Widget
/// Enumeration that defines the content types for the ad carousel
enum ContentType {
  productCard, // Product card
  image16x9, // Image with 16:9 aspect ratio
}

//TODO: Em fase de implementação após envio dos backgrounds padrão de fábrica para o storage
/// Class that represents the content of an item in the ad carousel
class AdvertisingCarouselContent {
  final ContentType type; // Content Type
  final Product? product; // Associated product (may be null if it is an image)
  final String? imageUrl; // Image URL (may be null if it is a product card)

  AdvertisingCarouselContent({
    required this.type,
    this.product,
    this.imageUrl,
  });
}
