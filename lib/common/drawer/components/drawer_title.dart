import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:brn_ecommerce/models/screens/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## DrawerTitle (Folder: common/drawer/components)
/// ### Components of Drawer Widget
/// Widget that represents a title item in the app drawer with an icon and text.
class DrawerTitle extends StatelessWidget {
  const DrawerTitle({super.key, this.iconData, this.title, this.page, this.onTap});

  final IconData? iconData;
  final String? title;
  final int? page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page!);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData!,
                size: 32,
                color: currentPage == page ? getEspecialColor() : Colors.grey[700],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                title!,
                style: TextStyle(
                  fontSize: 16,
                  color: currentPage == page ? getEspecialColor() : Colors.grey[700],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
