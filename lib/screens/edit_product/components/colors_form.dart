import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/screens/edit_product/components/edit_colors.dart';
import 'package:flutter/material.dart';

class ColorsForm extends StatelessWidget {
  const ColorsForm({Key? key, this.detailsProducts}) : super(key: key);

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






// class ColorsForm extends StatelessWidget {
//   const ColorsForm({Key? key, this.detailsProducts}) : super(key: key);
//
//   final DetailsProducts? detailsProducts;
//
//   @override
//   Widget build(BuildContext context) {
//     return FormField<List<ColorsProducts>>(
//         initialValue: detailsProducts?.colorProducts ?? [],
//         validator: (colorProducts) {
//           if (colorProducts!.isEmpty) {
//             return 'Insira uma Cor';
//           }
//           return null;
//         },
//         builder: (state) {
//           return Column(
//             children: [
//               Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Adicionar Cor Disponível',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   CustomIconButton(
//                       iconData: Icons.add,
//                       onTap: () {
//                         state.value?.add(ColorsProducts(amount: 0));
//                         state.didChange(state.value);
//                       }),
//                 ],
//               ),
//               Column(
//                 children: state.value!.map((color) {
//                   return EditColors(
//                     key: ObjectKey(color),
//                     colorsProducts: color,
//                     onRemove: () {
//                       state.value!.remove(color);
//                       state.didChange(state.value);
//                     },
//                   );
//                 }).toList(),
//               ),
//               if (state.hasError)
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     state.errorText!,
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 12,
//                     ),
//                   ),
//                 )
//             ],
//           );
//         });
//   }
// }
