import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/models/products/colors_products.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/views/product_edit/components/edit_colors.dart';
import 'package:flutter/material.dart';

class ColorsForm extends StatelessWidget {
  const ColorsForm({super.key, this.detailsProducts});

  final DetailsProducts? detailsProducts;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ColorsProducts>>(
      initialValue: detailsProducts?.colorProducts ?? [],
      validator: (colorProducts) {
        if (colorProducts!.isEmpty) {
          return 'Insira ao menos uma Cor';
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
                  child: Text(
                    'Adicione as cores deste produto!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.palette,
                  onTap: () {
                    state.value?.add(ColorsProducts(amount: 0));
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: state.value!.map((color) {
                  return EditColors(
                    key: ObjectKey(color),
                    colorsProducts: color,
                    onRemove: () {
                      state.value!.remove(color);
                      state.didChange(state.value);
                    },
                  );
                }).toList(),
              ),
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
