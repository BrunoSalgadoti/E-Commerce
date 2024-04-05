import 'package:flutter/cupertino.dart';

/// # PageManager (Folder: models/views)
///
/// A class responsible for managing the page navigation within a PageView.
class PageManager {
  // Proprieties

  final PageController _pageController;
  int page = 0;

  // Constructor

  /// Initializes a [PageManager] instance with the specified [PageController].
  PageManager(this._pageController);

  // Methods

  /// Sets the current page to the specified value.
  ///
  /// If the specified value is equal to the current page, no action is taken.
  void setPage(int value) {
    if (value == page) return;
    page = value;
    _pageController.jumpToPage(value);
  }
}
