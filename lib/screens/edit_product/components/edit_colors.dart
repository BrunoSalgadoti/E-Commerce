import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditColors extends StatefulWidget {
  const EditColors({
    Key? key,
    this.colorsProducts,
    this.onRemove,
    this.onColorChanged,
  }) : super(key: key);

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
              labelTypes: const [
                ColorLabelType.rgb,
                ColorLabelType.hsv,
                ColorLabelType.hsl
              ],
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
            child: TextFormField(
              initialValue: widget.colorsProducts?.amount.toString(),
              decoration: const InputDecoration(
                labelText: 'Qtd./cor?',
                isDense: true,
              ),
              validator: (amount) {
                if (int.tryParse(amount!) == null ||
                    int.tryParse(amount)! <= 0) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (amount) =>
                  widget.colorsProducts?.amount = int.tryParse(amount) ?? 0,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        const SizedBox(width: 70),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: widget.onRemove,
        ),
      ],
    );
  }

  String getHexColor(Color color) {
    String hexColor =
        '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    return hexColor;
  }
}
