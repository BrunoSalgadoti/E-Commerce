import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
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
            child: TextFormField(
              initialValue: detailsProducts?.size,
              decoration: const InputDecoration(
                labelText: 'Tamanho',
                isDense: true,
              ),
              validator: (size) {
                if (size!.isEmpty) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (size) => detailsProducts?.size = size.toUpperCase(),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 25,
            child: TextFormField(
              initialValue: detailsProducts?.stock.toString(),
              decoration: const InputDecoration(
                labelText: 'Estoque',
                isDense: true,
              ),
              validator: (stock) {
                if (int.tryParse(stock!) == null || int.tryParse(stock)! < 0) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (stock) =>
                  detailsProducts?.stock = int.tryParse(stock) ?? 0,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 50,
            child: TextFormField(
              initialValue: detailsProducts?.price?.toStringAsFixed(2),
              decoration: const InputDecoration(
                labelText: 'Preço',
                prefixText: 'R\$: ',
                isDense: true,
              ),
              validator: (price) {
                if (num.tryParse(price!) == null) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (price) =>
                  detailsProducts?.price = num.tryParse(price) ?? 0,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
