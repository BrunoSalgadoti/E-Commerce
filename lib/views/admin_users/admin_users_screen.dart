import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/messengers/search_dialog.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
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
        ),
        body: Consumer2<AdminUsersSearch, AdminUsersManager>(
          builder: (_, adminUsersSearch, adminUsersManager, __) {
            return AlphabetListScrollView(
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
            );
          },
        ));
  }
}
