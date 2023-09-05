import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/filters_sliding_up_panel.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/formated_fields/format_values.dart';
import '../../common/miscellaneous/freight_logo.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;

          return Column(children: [
            const FiltersSlidingUpPanel(),
            if (productManager.filtersOn == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Filtro Ativo:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                  Text(
                    "${productManager.activeFilterName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      productManager.disableFilter();
                    },
                  ),
                ],
              ),
            Expanded(
              child: filteredProducts.isEmpty
                  ? productManager.filtersOn == true
                      ? const EmptyPageIndicator(
                          title: 'Pesquisa não encontrada...',
                          iconData: Icons.search_off,
                          image: null,
                        )
                      : const EmptyPageIndicator(
                          title: "Carregando Produtos...",
                          image: "assets/images/await.gif",
                          iconData: null,
                        )
                  : ListView.builder(
                      itemCount: productManager.filtersOn == true
                          ? filteredProducts.length
                          : productManager.allProducts.length,
                      itemBuilder: (_, index) {
                        final product = filteredProducts.toList()[index];
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 7,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          child: Stack(children: [
                            FreightLogo(product: product, text: null),
                            Image.network(
                              product.images!.first,
                              fit: BoxFit.fill,
                              width: 89,
                              height: 85,
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              visualDensity: VisualDensity.comfortable,
                              leading: const SizedBox(
                                width: 89,
                              ),
                              title: Text(product.name!),
                              subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (product.brand != "")
                                        Text(
                                          'De marca: ${product.brand}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      Text('Quant. Disponível: '
                                          '${product.totalStock}'),
                                      product.hasStock
                                          ? Text('Menor Preço: '
                                              '${formattedRealText(product.basePrice)}')
                                          : const Text(
                                              'Fora de estoque',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ],
                                  )),
                              onTap: () {
                                Navigator.of(context).pop(product);
                              },
                            ),
                          ]),
                        );
                      },
                    ),
            )
          ]);
        },
      ),
    );
  }
}
