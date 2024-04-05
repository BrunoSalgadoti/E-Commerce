import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/views/home_manager.dart';
import 'package:brn_ecommerce/models/views/section.dart';
import 'package:brn_ecommerce/views/home/components/add_tile_widget.dart';
import 'package:brn_ecommerce/views/home/components/item_tile.dart';
import 'package:brn_ecommerce/views/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
        value: section,
        child: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
            child: Container(
              margin: const EdgeInsets.fromLTRB(18, 8, 18, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SectionHeader(section: section),
                Consumer<Section>(
                  builder: (_, section, __) {
                    return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          homeManager.editing ? section.items!.length + 1 : section.items!.length,
                      itemBuilder: (_, index) {
                        if (index < section.items!.length) {
                          return ItemTile(item: section.items![index]);
                        } else {
                          return const AddTileWidget();
                        }
                      },
                      staggeredTileBuilder: (index) => constraints.maxWidth > staggeredBreakpoint
                          ? StaggeredTile.count(1, index.isEven ? 0.75 : 1.5)
                          : StaggeredTile.count(2, index.isEven ? 1.5 : 3.0),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    );
                  },
                )
              ]),
            ),
          );
        }));
  }
}
