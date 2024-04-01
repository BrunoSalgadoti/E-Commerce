import 'package:brn_ecommerce/common/advertising/components/content_type.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';

/// ## UtilsForAdvertising (Folder: common/advertising/components)
/// ### Components of Advertising Widget
/// Utility class for loading content from the ADs carousel
class UtilsForAdvertising {
  /// Method for loading advertising products
  List<AdvertisingCarouselContent> loadAdvertisingProducts(ProductManager productManager) {
    List<AdvertisingCarouselContent> cardContents = [];

    List<Product> advertisingProducts = productManager.allProducts
        //TODO: Colocar em Product a variável  advertising
        // .where((product) => product.advertising == true)
        // .where((p) => p.product!.hasStock)
        .toList();

    cardContents = advertisingProducts
        .map((product) => AdvertisingCarouselContent(
              type: ContentType.productCard,
              product: product,
            ))
        .where((p) => p.product!.hasStock)
        .toList();

    return cardContents;
  }

  /// Method to load images selected by the administrator
  List<AdvertisingCarouselContent> loadAdminSelectedImages() {
    List<AdvertisingCarouselContent> imageContents = [];

    List<String> adminSelectedImages = [
      // TODO: introduzir estrutura para lista de imagens 16 / 9
    ];

    imageContents = adminSelectedImages
        .map((imageUrl) => AdvertisingCarouselContent(
              type: ContentType.image16x9,
              imageUrl: imageUrl,
            ))
        .toList();

    return imageContents;
  }
}
