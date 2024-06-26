import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/views/product_edit/components/colors_form.dart';
import 'package:brn_ecommerce/views/product_edit/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({super.key, this.product});

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Adicionar Item',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  onTap: () {
                    state.value?.add(DetailsProducts(stock: 0));
                    state.didChange(state.value);
                  },
                  semanticLabel: 'Adicionar item',
                ),
              ],
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: state.value!.map((size) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EditItemSize(
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
                    ),
                    ColorsForm(detailsProducts: size), // Nested FormField
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 2.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
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
      },
    );
  }
}
