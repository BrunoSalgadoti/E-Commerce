import 'package:brn_ecommerce/common/search/components/search_dialog.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget searchClients({
  required BuildContext context,
}) {
  return AppBar(
    title: Consumer<AdminUsersSearch>(
      builder: (_, adminUsersSearch, __) {
        if (adminUsersSearch.search.isEmpty) {
          return const Text('Clientes');
        } else {
          return GestureDetector(
            onTap: () async {
              final search = await showDialog<String>(
                  context: context,
                  builder: (_) => SearchDialog(
                        initialText: adminUsersSearch.search,
                        hintText: 'Pesquisar Cliente',
                      ));
              if (search != null) {
                adminUsersSearch.search = search;
              }
            },
            child: Container(
                color: const Color.fromARGB(16, 255, 255, 255),
                width: double.infinity,
                child: Text(
                  adminUsersSearch.search,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )),
          );
        }
      },
    ),
    centerTitle: true,
    actions: [
      Consumer<AdminUsersSearch>(
        builder: (_, adminUsersSearch, __) {
          if (adminUsersSearch.search.isEmpty) {
            return IconButton(
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(
                            initialText: adminUsersSearch.search,
                            hintText: 'Pesquisar Cliente',
                          ));
                  if (search != null) {
                    adminUsersSearch.search = search;
                  }
                },
                icon: const Icon(Icons.search));
          } else {
            return IconButton(
                onPressed: () async {
                  adminUsersSearch.search = '';
                  adminUsersSearch.filterList(adminUsersSearch.allUsers);
                },
                icon: const Icon(Icons.close));
          }
        },
      )
    ],
  );
}
