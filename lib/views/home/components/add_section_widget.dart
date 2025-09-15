import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/models/home_sections/home_manager.dart';
import 'package:brn_ecommerce/models/home_sections/section.dart';
import 'package:flutter/material.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({super.key, required this.homeManager});

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: CustomButton(
              text: 'Adicionar Lista',
              onPressed: () {
                homeManager.addSection(Section(type: 'List'));
              },
            ),
          ),
          const SizedBox(
            width: 28,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: CustomButton(
              text: 'Adicionar Grade',
              onPressed: () {
                homeManager.addSection(Section(type: 'Staggered'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
