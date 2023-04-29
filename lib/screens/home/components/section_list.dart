import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/section.dart';
import 'package:ecommerce/screens/home/components/add_tile_widget.dart';
import 'package:ecommerce/screens/home/components/item_tile.dart';
import 'package:ecommerce/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList({Key? key,
    required this.section
  }) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(),
            SizedBox(
              height: 150,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      if (index < section.items!.length) {
                        return ItemTile(item: section.items![index]);
                      } else {
                        return const AddTileWidget();
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 4),
                    itemCount: homeManager.editing
                        ? section.items!.length + 1
                        : section.items!.length,
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
