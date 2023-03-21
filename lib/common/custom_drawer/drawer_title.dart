import 'package:ecommerce/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTitle extends StatelessWidget {
   const DrawerTitle({super.key, this.iconData, this.title, this.page});

  final IconData? iconData;
  final String? title;
  final int? page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;
    final Color primarycolor = Theme.of(context).primaryColor;

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
                color: currentPage == page ? primarycolor : Colors.grey[700],
              ),
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                color: currentPage == page ? primarycolor : Colors.grey[700],
              ),
            )],
        ),
      ),
    );
  }
}
