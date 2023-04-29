import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/section.dart';
import 'package:flutter/material.dart';

class AddSectionWidget extends StatelessWidget {
    const AddSectionWidget({Key? key,
     required this.homeManager
   }) : super(key: key);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
            child: CustomButton(
              texto: 'Adicionar Lista',
              onPressed: () {
                homeManager.addSection(Section(type: 'List'));
              },
              corBotao: Colors.transparent,
            )
        ),
        const SizedBox(width: 20,),
        Expanded(
            child: CustomButton(
              texto: 'Adicionar Grade',
              onPressed: () {
                homeManager.addSection(Section(type: 'Staggered'));
              },
              corBotao: Colors.transparent,
            )
        ),
      ],
    );
  }
}
