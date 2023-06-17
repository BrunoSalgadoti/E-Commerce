import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/who_we_are_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';

class TopDescriptionWidget extends StatefulWidget {
  const TopDescriptionWidget({super.key});

  @override
  State<TopDescriptionWidget> createState() => _TopDescriptionWidgetState();
}

class _TopDescriptionWidgetState extends State<TopDescriptionWidget> {
  late TextEditingController controllerText;

  @override
  void initState() {
    super.initState();
    controllerText = TextEditingController();
  }

  @override
  void dispose() {
    controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? adminCustomText = 'Bem Vindo!\n Customize a sua apresentação'
        '\n Clique no ícone da vassoura e comece!';

    return Consumer2<WhoWeAreManager, UserManager>(
        builder: (_, whoWeAreManager, userManager, __) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<void>(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Carregando...');
                  } else {
                    return MarkdownBody(
                      data: whoWeAreManager.topDescription ??
                          'Parabéns! Você adquiriu um produto '
                              'com a qualidade BRN Info_Dev',
                      shrinkWrap: true,
                    );
                  }
                },
              ),
            ),
            if (userManager.adminEnable)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: MarkdownTextInput(
                  (customText) =>
                      whoWeAreManager.topDescription = customText,
                  whoWeAreManager.topDescription ?? adminCustomText,
                  label: 'Apresentação: Quem somos?',
                  maxLines: null,
                  actions: MarkdownType.values,
                  controller: controllerText,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (userManager.adminEnable)
                  CustomTextButton(
                    text: null,
                    icon: const Icon(FontAwesomeIcons.broom),
                    onPressed: () => controllerText.clear(),
                  ),
                if (userManager.adminEnable)
                  CustomTextButton(
                    text: null,
                    icon: const Icon(
                      FontAwesomeIcons.check,
                    ),
                    onPressed: () async {
                      await whoWeAreManager.saveDescriptions();
                    },
                  ),
              ],
            )
          ]));
    });
  }
}
