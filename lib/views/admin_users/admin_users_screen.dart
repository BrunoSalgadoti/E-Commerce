import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/search/search_clients.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: Scaffold(
              backgroundColor: Colors.black45,
              drawer: const CustomDrawer(),
              appBar: searchClients(context: context),
              body: Consumer2<AdminUsersSearch, AdminUsersManager>(
                builder: (_, adminUsersSearch, adminUsersManager, __) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                      child: AlphabetListScrollView(
                        strList: adminUsersSearch.names,
                        normalTextStyle: const TextStyle(color: Colors.white),
                        highlightTextStyle: const TextStyle(
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                        showPreview: true,
                        itemBuilder: (context, index) {
                          return adminUsersSearch.normalList[index];
                        },
                        indexedHeight: (i) {
                          return 70;
                        },
                        keyboardUsage: true,
                        headerWidgetList: <AlphabetScrollListHeader>[
                          AlphabetScrollListHeader(
                              widgetList: adminUsersSearch.favouriteList,
                              icon: const Icon(Icons.star),
                              indexedHeaderHeight: (index) {
                                return 70;
                              }),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
