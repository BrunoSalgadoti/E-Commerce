import 'package:ecommerce/common/button/custom_icon_button.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/edit_product/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({
    Key? key,
    this.product
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<DetailsProducts>>(
        initialValue: product!.itemProducts,
        validator: (itemProducts) {
          if (itemProducts!.isEmpty) {
            return 'Insira um Item';
          }
          return null;
        },
        builder: (state) {
          return Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Adicionar Item',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomIconButton(
                      iconData: Icons.add,
                      onTap: () {
                        state.value?.add(DetailsProducts(stock: 0));
                        state.didChange(state.value);
                      }),
                ],
              ),
              Column(
                children: state.value!.map((size) {
                  return EditItemSize(
                    key: ObjectKey(size),
                    detailsProducts: size,
                    onRemove: () {
                      state.value!.remove(size);
                      state.didChange(state.value);
                    },
                    onMoveUp: size != state.value!.first
                        ? () {
                            final index = state.value!.indexOf(size);
                            state.value!.remove(size);
                            state.value!.insert(index - 1, size);
                            state.didChange(state.value);
                          }
                        : null,
                    onMoveDown: size != state.value!.last
                        ? () {
                            final index = state.value!.indexOf(size);
                            state.value!.remove(size);
                            state.value!.insert(index + 1, size);
                            state.didChange(state.value);
                          }
                        : null,
                  );
                }).toList(),
              ),
              if (state.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          );
        });
  }
}
