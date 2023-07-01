import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/screens/edit_product/components/colors_form.dart';
import 'package:brn_ecommerce/screens/edit_product/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({Key? key, this.product}) : super(key: key);

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
                  child:  Text(
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
                      ColorsForm(detailsProducts: size), // Novo FormField aninhado
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