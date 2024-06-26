import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/models/products/colors_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/functions/common_functions.dart';

class EditColors extends StatefulWidget {
  const EditColors({
    super.key,
    this.colorsProducts,
    this.onRemove,
    this.onColorChanged,
  });

  final ColorsProducts? colorsProducts;
  final VoidCallback? onRemove;
  final ValueChanged<Color>? onColorChanged;

  @override
  EditColorsState createState() => EditColorsState();
}

class EditColorsState extends State<EditColors> {
  Color _selectedColor = Colors.transparent;

  void _showColorPicker() {
    Color initialColor = widget.colorsProducts?.realColor ?? Colors.transparent;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione uma cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                  widget.onColorChanged?.call(color);
                  widget.colorsProducts?.realColor = color;
                  widget.colorsProducts?.color = getHexColor(color);
                });
              },
              labelTypes: const [ColorLabelType.rgb, ColorLabelType.hsv, ColorLabelType.hsl],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: _showColorPicker,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Container(
                color: widget.colorsProducts?.realColor ?? _selectedColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 80,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomTextFormField(
              initialValue: widget.colorsProducts?.amount.toString(),
              labelText: 'Qtd./cor?',
              textInputType: TextInputType.number,
              validator: (amount) {
                if (int.tryParse(amount!) == null || int.tryParse(amount)! < 0) {
                  return 'Valor Inválido';
                }
                return null;
              },
              onChanged: (amount) => widget.colorsProducts?.amount = int.tryParse(amount!) ?? 0,
            ),
          ),
        ),
        const SizedBox(width: 70),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: widget.onRemove,
          semanticLabel: 'Remover cor',
        ),
      ],
    );
  }
}
