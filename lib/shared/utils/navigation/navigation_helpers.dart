
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/shared/widgets/navigation/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/shared/widgets/navigation/drawer/components/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void navigateToPageWithDrawer({
  required BuildContext context,
  required DrawerPages page,
}) {
  // Closes the current page and opens the Home page (or the one with the Drawer)
  Navigator.popAndPushNamed(context, RoutesNavigator.homeScreen);

  // Schedule page change in PageManager
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<PageManager>().setPage(page);
  });
}
