import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    //TODO: ajustar layout
    return Stack(
      children: [
        Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          semanticContainer: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity, // 16x9 aspect ratio
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/CategoriesBackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          //Card principal
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                product.images!.first,
                //TODO: Substituir pelo caminho da foto do produto == advertising true
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//TODO: usar como molde
// Stack(
//   fit: StackFit.expand,
//   children: [
//     Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1.5,
//               blurRadius: 4,
//               offset: const Offset(0, 5),
//             ),
//           ]),
//       clipBehavior: Clip.antiAlias,
//       child: Image.network(
//         image.images!.first,
//         fit: BoxFit.cover,
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.all(10),
//       child: TagForCard(
//           data: 'A partir:\n '
//               '${formattedRealText(image.basePrice)}',
//           googleFonts: GoogleFonts.akayaTelivigala,
//           textFontSize: 16,
//           alignment: Alignment.bottomLeft,
//           backgroundColor: Colors.white,
//           containerWidth: 90),
//     ),
//     Positioned(
//       bottom: 10,
//       right: 10,
//       child: Material(
//           color: Theme.of(context).primaryColor.withAlpha(90),
//           child: IconButton(
//               icon: const Icon(Icons.open_in_new,
//                   semanticLabel: 'Visualizar Produto',
//                   size: 20,
//                   color: Colors.white),
//               onPressed: () {
//                 //TODO: Rota para a tela do Produto
//               })),
//     ),
//     Positioned(
//       bottom: 10,
//       right: 10,
//       child: Container(),
//     ),
//   ],
// );
