import 'package:ecommerce/models/section.dart';
import 'package:ecommerce/screens/home/components/item_tile.dart';
import 'package:ecommerce/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered({Key? key, this.section}) : super(key: key);

  final Section? section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(section: section!),
            StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: section?.items!.length,
              itemBuilder: (_, index) {
                return ItemTile(item: section!.items![index]);
              },
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 2  : 2.68),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            )
          ]
      ),
    );
  }
}
