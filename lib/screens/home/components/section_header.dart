import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/home_manager.dart';
import 'package:brn_ecommerce/models/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.section,
  }) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    if (homeManager.editing) {
      final int sectionIndex = homeManager.sections.indexOf(section);
      final bool isFirstSection = sectionIndex == 0;
      final bool isLastSection =
          sectionIndex == homeManager.sections.length - 1;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                    hintText: 'Adicionar Título',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIconButton(
                iconData: Icons.move_up,
                color: Colors.white,
                onTap: isFirstSection
                    ? null
                    : () {
                        homeManager.moveSectionUp(section);
                      },
              ),
              CustomIconButton(
                iconData: Icons.move_down,
                color: Colors.white,
                onTap: isLastSection
                    ? null
                    : () {
                        homeManager.moveSectionDown(section);
                      },
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
        child: Text(
          section.name!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}
