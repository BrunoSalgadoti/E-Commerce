import 'package:ecommerce/common/button/custom_icon_button.dart';
import 'package:ecommerce/models/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
   const CartTile({Key? key, required this.cartProduct}) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product!.images!.first),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.product!.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Tamanho: ${cartProduct.size}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                        Consumer<CartProduct>(
                          builder: (_, cartProduct, __){
                            if(cartProduct.hasStock) {
                            return Text(
                              'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            );
                            } else if (cartProduct.unitQuantity != 0){
                              return Text(
                                  'Sem estoque suficiente!\n'
                                      'Quantidade Dispon??vel: '
                                      '${cartProduct.unitQuantity}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12
                                ),
                              );
                            } else {
                             return const  Text('Estoque Esgotado!');
                            }
                          },
                        )
                      ],
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Consumer<CartProduct>(
                  builder: (_, cartProduct, __) {
                    return Column(
                    children: [
                      CustomIconButton(
                        iconData: cartProduct.quantity! > cartProduct.unitQuantity
                            ? Icons.not_interested : Icons.add,
                        onTap: cartProduct.increment,
                        color: cartProduct.quantity! > cartProduct.unitQuantity
                            ? Colors.red : Theme.of(context).primaryColor,
                      ),
                      Text(
                        '${cartProduct.quantity}',
                        style: const TextStyle(
                            fontSize: 20
                        ),
                      ),
                      CustomIconButton(
                        iconData: cartProduct.quantity! == 1
                            ? Icons.delete
                            : Icons.remove,
                        onTap: cartProduct.decrement,
                        color: cartProduct.quantity! > 1
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                      ),
                    ],
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
