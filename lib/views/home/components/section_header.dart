import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/sections_home/home_manager.dart';
import 'package:brn_ecommerce/models/sections_home/section.dart';
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

    // Ensures that the BestSelling section is always in the edit list
    if (homeManager.editing &&
        !homeManager.sections.contains(section) &&
        section.type == 'BestSelling') {
      homeManager.enterEditing();
    }

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
                  textFormFieldColor: getCustomAppBarColorIcons().withAlpha(90),
                  textFormFieldBold: true,
                  textFormFieldSize: 18,
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIconButton(
                iconData: Icons.move_up,
                color: getCustomAppBarColorIcons(),
                onTap: isFirstSection
                    ? null
                    : () {
                  homeManager.moveSectionUp(section);
                },
                semanticLabel: 'Mover para cima',
              ),
              CustomIconButton(
                iconData: Icons.move_down,
                color: getCustomAppBarColorIcons(),
                onTap: isLastSection
                    ? null
                    : () {
                  homeManager.moveSectionDown(section);
                },
                semanticLabel: 'Mover para baixo',
              ),
              const SizedBox(width: 20),

              // 🔥 Only show the remove button if it is NOT BestSelling
              if (section.type != "BestSelling")
                CustomIconButton(
                  iconData: Icons.remove,
                  color: getCustomAppBarColorIcons(),
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
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    } else {
      return textForGoogleDecorations(
        titleForDecorations: section.name!,
        fontMethod: GoogleFonts.bungeeSpice,
      );
    }
  }
}
