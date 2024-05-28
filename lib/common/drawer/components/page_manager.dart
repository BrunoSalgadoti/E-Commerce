import 'package:brn_ecommerce/common/drawer/components/drawer_page_view.dart';
import 'package:flutter/cupertino.dart';

/// # PageManager (Folder: models/views)
///
/// A class responsible for managing the page navigation within a PageView.
class PageManager extends ChangeNotifier {
  // Proprieties

  int page = 0;

  // Methods

  /// Sets the current page to the specified value.
  ///
  /// If the specified value is equal to the current page, no action is taken.
  void setPage(int value) {
    if (value == page) return;
    page = value;
    ControllerPageView.pageController.jumpToPage(value);
    notifyListeners();
  }
}
