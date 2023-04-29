import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/section.dart';
import 'package:ecommerce/screens/home/components/add_tile_widget.dart';
import 'package:ecommerce/screens/home/components/item_tile.dart';
import 'package:ecommerce/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionHeader(),
          Consumer<Section>(
            builder: (_, section, __) {
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: homeManager.editing
                    ? section.items!.length + 1
                    : section.items!.length,
                itemBuilder: (_, index) {
                  if (index < section.items!.length) {
                    return ItemTile(item: section.items![index]);
                  } else {
                    return const AddTileWidget();
                  }
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 2.68),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              );
            },
          )
        ]),
      ),
    );
  }
}
