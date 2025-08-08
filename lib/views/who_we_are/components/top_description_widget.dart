import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/who_we_are_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
// import 'package:markdown_editable_textinput/format_markdown.dart';
// import 'package:markdown_editable_textinput/markdown_text_input.dart';
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
    String? adminCustomText = "Bem Vindo!\n Customize a sua apresentação"
        "\n Clique no ícone da vassoura e comece!";

    return Consumer2<WhoWeAreManager, UserManager>(builder: (_, whoWeAreManager, userManager, __) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: FutureBuilder<void>(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Carregando...');
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            color: const Color.fromARGB(155, 132, 178, 239),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: MarkdownBody(
                                data: whoWeAreManager.topDescription ??
                                    "Parabéns! Você adquiriu um produto "
                                        "com a qualidade BRN Info_Dev",
                                styleSheet: MarkdownStyleSheet(
                                  p: const TextStyle(color: Colors.white),
                                  pPadding: const EdgeInsets.all(4),
                                ),
                                shrinkWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            if (userManager.adminEnable)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: MarkdownToolbar(
                  useIncludedTextField: false,
                  controller: controllerText,
                  // focusNode: _focusNode,
                  // You can customize the toolbar here as needed
                  // For example:
                  // backgroundColor: Colors.lightBlue,
                  // iconColor: Colors.white,
                  // iconSize: 30,
                ),
              ),
            const Divider(),
            CustomTextFormField(
              title: whoWeAreManager.topDescription ?? adminCustomText,
              labelText: 'Apresentação: Quem somos?',
              controller: controllerText,
              titleSize: 16,
              maxLength: null,
              onChanged: (customText) => whoWeAreManager.topDescription = customText,
            ),

            // MarkdownTextInput(
            //   (customText) => whoWeAreManager.topDescription = customText,
            //   whoWeAreManager.topDescription ?? adminCustomText,
            //   label: 'Apresentação: Quem somos?',
            //   maxLines: null,
            //   actions: const [
            //     MarkdownType.bold,
            //     MarkdownType.italic,
            //     MarkdownType.title,
            //     MarkdownType.separator,
            //     MarkdownType.strikethrough,
            //     MarkdownType.code,
            //     MarkdownType.list,
            //     MarkdownType.blockquote,
            //   ],
            //   controller: controllerText,
            //   textStyle: const TextStyle(fontSize: 16),
            // ),

            // ),
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
