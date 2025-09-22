import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsivePageWrapper extends StatefulWidget {
  final Widget Function(void Function()? toggleDrawer) pageContentBuilder;
  final String? appBarTitle;

  const ResponsivePageWrapper({
    super.key,
    required this.pageContentBuilder,
    this.appBarTitle,
  });

  @override
  ResponsivePageWrapperState createState() => ResponsivePageWrapperState();
}

class ResponsivePageWrapperState extends State<ResponsivePageWrapper> {
  bool drawerOpen = false;
  final double openWidth = 260;
  final double collapsedWidth = 60;

  void toggleDrawer() => setState(() => drawerOpen = !drawerOpen);

  @override
  Widget build(BuildContext context) {
    final bool isWebExpanded = MediaQuery.of(context).size.width >= staggeredBreakpoint;
    final bool isHome = (widget.appBarTitle ?? '') == '';
    final void Function()? toggleForChild = isWebExpanded ? toggleDrawer : null;
    final Widget content = widget.pageContentBuilder(toggleForChild);
    final topPadding = kIsWeb ? 0.0 : MediaQuery.of(context).padding.top;

    if (isWebExpanded) {
      return Row(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [getDrawerColorFirst(), getDrawerColorSecond()],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: double.infinity,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            width: drawerOpen ? openWidth : collapsedWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: drawerOpen ? openWidth : collapsedWidth,
                minWidth: collapsedWidth,
              ),

              // Only shows the header when the drawer is open
              child: drawerOpen
                  ? const CustomDrawer(isCollapsed: false)
                  : _collapsedDrawerDynamically(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: Scaffold(
                drawer: isHome ? null : const CustomDrawer(),
                drawerEnableOpenDragGesture: !isHome,
                appBar: isHome
                    ? null
                    : AppBar(
                        title: Text(widget.appBarTitle ?? ''),
                        leading: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: toggleDrawer,
                        ),
                      ),
                body: Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: content,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        drawer: const CustomDrawer(),
        appBar: isHome ? null : AppBar(title: Text(widget.appBarTitle ?? '')),
        body: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: content,
        ),
      );
    }
  }

  Widget _collapsedDrawerDynamically() {
    final itemsClient = const CustomDrawer().drawerItemsClient(context);
    final itemsStores = const CustomDrawer().drawerItemsStores(context);
    final admin = const CustomDrawer().adminItemsAdm(context);

    final drawerItems = [
      ...itemsClient,
      ...itemsStores,
      ...admin,
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [getDrawerColorFirst(), getDrawerColorSecond()],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: drawerItems.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: IconButton(
              icon: Icon(item.icon, size: 28),
              tooltip: item.title,
              onPressed: () {
                final pageManager = Provider.of<PageManager>(context, listen: false);
                pageManager.setPage(item.page);
                setState(() => drawerOpen = false);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
