import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Usuários',
        showDrawerIcon: false,
        showSearchButton: false,
      ),
      body: Consumer2<AdminUsersSearch, AdminUsersManager>(
        builder: (_, adminUsersSearch, adminUsersManager, __) {
          // Atualiza a lista de usuários após o frame ser renderizado
          WidgetsBinding.instance.addPostFrameCallback((_) {
            adminUsersSearch.setUsers(adminUsersManager.userList);
          });

          // Combina favoritos e normais para exibição
          final allWidgets = [
            ...adminUsersSearch.favouriteList,
            ...adminUsersSearch.normalList,
          ];

          return AlphabetScrollView(
            list: adminUsersSearch.allUsers.map((u) => AlphaModel(u.userName ?? '')).toList(),
            alignment: LetterAlignment.right,
            itemExtent: 70,
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
          );
        },
      ),
    );
  }
}
