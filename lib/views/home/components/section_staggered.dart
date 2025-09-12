import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/sections_home/home_manager.dart';
import 'package:brn_ecommerce/models/sections_home/section.dart';
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(section: section),
                    Consumer<Section>(
                      builder: (_, section, __) {
                        final items = section.items ?? [];

                        // Decide item limit based on breakpoint
                        final maxItems = constraints.maxWidth >= mobileBreakpoint ? 10 : 7;

                        // Check if there are enough images
                        final hasMinItems = items.length >= 10;

                        return Column(
                          children: [
                            if (!hasMinItems)
                              Container(
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Adicione pelo menos 10 imagens para esta seção.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            StaggeredGridView.countBuilder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              crossAxisCount: constraints.maxWidth > mobileBreakpoint ? 5 : 4,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeManager.editing
                                  ? (items.length.clamp(0, maxItems) + 1)
                                  : items.length.clamp(0, maxItems),
                              itemBuilder: (_, index) {
                                if (index < items.length.clamp(0, maxItems)) {
                                  return ItemTile(item: items[index]);
                                } else {
                                  // add button
                                  return const AddTileWidget();
                                }
                              },
                              staggeredTileBuilder: (index) =>
                                  constraints.maxWidth > mobileBreakpoint
                                      ? const StaggeredTile.count(1, 1.1)
                                      : StaggeredTile.count(2, index.isEven ? 1.4 : 2.8),
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
