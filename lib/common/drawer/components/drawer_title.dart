import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## DrawerTitle (Folder: common/drawer/components)
/// ### Components of Drawer Widget
/// Widget that represents a title item in the app drawer with an icon and text.
class DrawerTitle extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final int? page;
  final VoidCallback? onTap;

  const DrawerTitle({super.key, this.iconData, this.title, this.page, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageManager>(builder: (_, pageManager, __) {
      return InkWell(
        onTap: () => pageManager.setPage(page!),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Icon(
                  iconData!,
                  size: 32,
                  color: pageManager.page == page ? getEspecialColor() : Colors.grey[700],
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
                    color: pageManager.page == page ? getEspecialColor() : Colors.grey[700],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
