import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/search/search_clients.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(
        title: SearchClients().searchClientsTextAppBar(context: context),
        showDrawerIcon: true,
        showSearchButton: false,
        actions: [SearchClients().actionsSearchClients(context: context)],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: tabletBreakpoint),
          child: Consumer2<AdminUsersSearch, AdminUsersManager>(
            builder: (_, adminUsersSearch, adminUsersManager, __) {
              if (!listEquals(adminUsersSearch.allUsers, adminUsersManager.userList)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  adminUsersSearch.setUsers(adminUsersManager.userList);
                });
              }

              // TEMPLATES and WIDGETS in consistent order
              final visibleUsers = [
                ...adminUsersSearch.favouriteUsers,
                ...adminUsersSearch.normalUsers,
              ];
              final allWidgets = [
                ...adminUsersSearch.favouriteList,
                ...adminUsersSearch.normalList,
              ];

              if (visibleUsers.isEmpty) {
                return const Center(child: Text('Nenhum cliente encontrado.'));
              }

              return Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: mobileBreakpoint,
                  ),
                  color: kIsWeb ? Colors.white : Colors.yellow.withAlpha(90),
                  child: AlphabetScrollView(
                    list: visibleUsers.map((u) => AlphaModel(u.userName ?? '')).toList(),
                    alignment: LetterAlignment.right,
                    itemExtent: 75,
                    unselectedTextStyle: TextStyle(
                      fontSize: 18,
                      color: getTextColor(),
                    ),
                    selectedTextStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    overlayWidget: (value) => Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.star, size: 55, color: Colors.green),
                        Text(
                          value.toUpperCase(),
                          style: TextStyle(fontSize: 18, color: getTextColor()),
                        ),
                      ],
                    ),
                    itemBuilder: (_, index, __) => allWidgets[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
