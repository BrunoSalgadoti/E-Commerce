import 'package:flutter/widgets.dart';

class PageManager extends ChangeNotifier {
  int page = 0;
  final PageController pageController;

  PageManager() : pageController = PageController(initialPage: 0);

  void setPage(int value) {
    if (value == page) return;
    page = value;

    if (pageController.hasClients) {
      pageController.jumpToPage(value);
    } else {
      // Agenda a tentativa para quando a árvore estiver pronta
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(value);
        }
      });
    }

    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}