import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/models/views/home_manager.dart';
import 'package:brn_ecommerce/models/views/section.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.section,
  });

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    if (homeManager.editing) {
      final int sectionIndex = homeManager.sections.indexOf(section);
      final bool isFirstSection = sectionIndex == 0;
      final bool isLastSection = sectionIndex == homeManager.sections.length - 1;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                initialValue: section.name,
                hintText: 'Adicionar Título',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                textFormFieldColor: Colors.white,
                textFormFieldBold: true,
                textFormFieldSize: 18,
                onChanged: (text) => section.name = text,
              )),
              CustomIconButton(
                iconData: Icons.move_up,
                color: Colors.white,
                onTap: isFirstSection
                    ? null
                    : () {
                        homeManager.moveSectionUp(section);
                      },
                semanticLabel: 'Mover para cima',
              ),
              CustomIconButton(
                iconData: Icons.move_down,
                color: Colors.white,
                onTap: isLastSection
                    ? null
                    : () {
                        homeManager.moveSectionDown(section);
                      },
                semanticLabel: 'Mover para baixo',
              ),
              const SizedBox(
                width: 20,
              ),
              CustomIconButton(
                iconData: Icons.remove,
                color: Colors.white,
                onTap: () {
                  homeManager.removeSection(section);
                },
                semanticLabel: 'Remover seção',
              ),
            ],
          ),
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section.error!,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: DecoratedGoogleFontText(
          section.name!,
          fontMethod: GoogleFonts.bungeeSpice,
          fillColor: Colors.transparent,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          borderWidth: 0.8,
        ),
      );
    }
  }
}
