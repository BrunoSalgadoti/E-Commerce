import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/models/home_manager.dart';
import 'package:brn_ecommerce/models/section.dart';
import 'package:flutter/material.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({Key? key, required this.homeManager})
      : super(key: key);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomButton(
          text: 'Adicionar Lista',
          onPressed: () {
            homeManager.addSection(Section(type: 'List'));
          },
        )),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: CustomButton(
          text: 'Adicionar Grade',
          onPressed: () {
            homeManager.addSection(Section(type: 'Staggered'));
          },
        )),
      ],
    );
  }
}
