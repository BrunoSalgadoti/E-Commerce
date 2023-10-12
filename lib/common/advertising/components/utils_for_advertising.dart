import 'package:brn_ecommerce/common/advertising/components/content_type.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';

class UtilsForAdvertising {
  List<AdvertisingCarouselContent> loadAdvertisingProducts(ProductManager productManager) {
    List<AdvertisingCarouselContent> cardContents = [];

    List<Product> advertisingProducts = productManager.allProducts
        //TODO: Colocar em Product a variável  advertising
        // .where((product) => product.advertising == true)
        .toList();

    cardContents = advertisingProducts
        .map((product) => AdvertisingCarouselContent(
              type: ContentType.productCard,
              product: product,
            ))
        .toList();

    return cardContents;
  }

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
