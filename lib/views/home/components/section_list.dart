import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/sections_home/home_manager.dart';
import 'package:brn_ecommerce/models/sections_home/section.dart';
import 'package:brn_ecommerce/views/home/components/add_tile_widget.dart';
import 'package:brn_ecommerce/views/home/components/item_tile.dart';
import 'package:brn_ecommerce/views/home/components/section_header.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final ScrollController scrollController = ScrollController();

    return ChangeNotifierProvider.value(
      value: section,
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
          child: Container(
            margin: const EdgeInsets.fromLTRB(18, 8, 18, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionHeader(section: section),
                SizedBox(
                    height: constraints.maxWidth <= mobileBreakpoint ? 160 : 280,
                    child: Consumer<Section>(
                      builder: (_, section, __) {
                        return Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.bottom,
                          thumbVisibility: kIsWeb ? true : false,
                          trackVisibility: kIsWeb ? true : false,
                          interactive: kIsWeb ? true : false,
                          controller: scrollController,
                          child: ListView.separated(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              if (index < section.items!.length) {
                                return ItemTile(item: section.items!.reversed.toList()[index]);
                              } else {
                                return const AddTileWidget();
                              }
                            },
                            separatorBuilder: (_, __) => const SizedBox(width: 4),
                            itemCount: homeManager.editing
                                ? section.items!.length + 1
                                : section.items!.length,
                          ),
                        );
                      },
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
