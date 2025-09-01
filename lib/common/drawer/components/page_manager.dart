import 'package:flutter/widgets.dart';

import 'drawer_pages_enum.dart';

class PageManager extends ChangeNotifier {
  DrawerPages currentPage = DrawerPages.home; // enum agora

  final PageController pageController;

  PageManager() : pageController = PageController(initialPage: 0);

  void setPage(DrawerPages page) {
    if (page == currentPage) return;
    currentPage = page;

    // Mapeia o enum para índice do PageView
    int pageIndex = _getPageIndex(page);

    if (pageController.hasClients) {
      pageController.jumpToPage(pageIndex);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(pageIndex);
        }
      });
    }

    notifyListeners();
  }

  int _getPageIndex(DrawerPages page) {
    switch (page) {
      case DrawerPages.home:
        return 0;
      case DrawerPages.categories:
        return 1;
      case DrawerPages.orders:
        return 2;
      case DrawerPages.favorites:
        return 3;
      case DrawerPages.wishlist:
        return 4;
      case DrawerPages.stores:
        return 5;
      case DrawerPages.whoWeAre:
        return 6;
      case DrawerPages.adminUsers:
        return 7;
      case DrawerPages.adminOrders:
        return 8;
      case DrawerPages.products:
        return 9;
    }
  }
}
