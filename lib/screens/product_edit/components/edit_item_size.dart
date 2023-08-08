import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:flutter/material.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({
    Key? key,
    this.detailsProducts,
    this.onRemove,
    this.onAdd,
    this.onMoveUp,
    this.onMoveDown,
  }) : super(key: key);

  final DetailsProducts? detailsProducts;
  final VoidCallback? onRemove;
  final VoidCallback? onAdd;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            flex: 25,
            child: CustomTextFormField(
              initialValue: detailsProducts?.size,
              labelText: 'Tamanho',
              validator: (value) => emptyValidator(value),
              onChanged: (size) => detailsProducts?.size = size?.toUpperCase(),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 25,
            child: CustomTextFormField(
              initialValue: detailsProducts?.stock.toString(),
              labelText: 'Estoque',
              textInputType: TextInputType.number,
              validator: (stock) {
                if (int.tryParse(stock!) == null || int.tryParse(stock)! < 0) {
                  return 'Valor Inválido';
                }
                return null;
              },
              onChanged: (stock) =>
                  detailsProducts?.stock = int.tryParse(stock!) ?? 0,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 50,
            child: CustomTextFormField(
              initialValue: detailsProducts?.price?.toStringAsFixed(2),
              labelText: 'Preço',
              prefixText: 'R\$: ',
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (price) {
                if (num.tryParse(price!) == null) {
                  return 'Valor Inválido';
                }
                return null;
              },
              onChanged: (price) =>
                  detailsProducts?.price = num.tryParse(price!) ?? 0,
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Colors.red,
            onTap: onRemove,
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_up,
            onTap: onMoveUp,
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_down,
            onTap: onMoveDown,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
    ]);
  }
}
