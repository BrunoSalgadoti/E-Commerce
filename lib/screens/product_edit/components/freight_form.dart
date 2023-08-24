import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';


class FreightForm extends StatelessWidget {
  const FreightForm({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'F R E T E',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 245, 238, 125),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField<bool>(
              value: product?.freight,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              isDense: true,
              isExpanded: true,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero, // Remove any padding
              ),
              onChanged: (bool? newValue) {
                product?.freight = newValue;
              },
              items: const [
                DropdownMenuItem<bool>(
                  value: true,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Sim'),
                  ),
                ),
                DropdownMenuItem<bool>(
                  value: false,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('NÃO'),
                  ),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Obrigatório';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
