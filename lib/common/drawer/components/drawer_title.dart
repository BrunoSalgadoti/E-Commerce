import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart' show PageManager;
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_pages_enum.dart';

class DrawerTitle extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final DrawerPages? page;

  const DrawerTitle({super.key, this.iconData, this.title, this.page});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageManager>(
      builder: (_, pageManager, __) {
        return InkWell(
          onTap: () => pageManager.setPage(page!),
          child: ClipRect(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Flexible(
                      child: CustomIconButton(
                        iconData: iconData!,
                        size: 32,
                        color:
                            pageManager.currentPage == page ? getEspecialColor() : Colors.grey[700],
                        semanticLabel: '',
                        onTap: () {},
                      ),
                    ),
                  SizedBox(width: 10),
                  Expanded(
                    child: AutoSizeText(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      minFontSize: 2,
                      maxFontSize: 16,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            pageManager.currentPage == page ? getEspecialColor() : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}