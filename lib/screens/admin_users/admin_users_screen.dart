import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:ecommerce/models/admin_users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            strList:adminUsersManager.names,
            normalTextStyle: const TextStyle(
                color: Colors.white
            ),
            highlightTextStyle: const TextStyle(
              fontSize: 25,
              color: Colors.yellow,
            ),
            showPreview: true,
            itemBuilder: (context, index) {
             return adminUsersManager.normalList[index];
                },
            indexedHeight: (i) {
              return 70;
            },
            keyboardUsage: true,
            headerWidgetList: <AlphabetScrollListHeader>[
              AlphabetScrollListHeader(
                  widgetList: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    controller: adminUsersManager.searchController,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(100, 100, 100, 125),
                      border: OutlineInputBorder(),
                      suffix: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      labelText: 'Buscar por Cliente',
                    ),
                  ),
                )
              ], icon: const Icon(Icons.search),
                  indexedHeaderHeight: (index) => 80
              ),
              AlphabetScrollListHeader(
                  widgetList: adminUsersManager.favouriteList,
                  icon: const Icon(Icons.star),
                  indexedHeaderHeight: (index) {
                    return 80;
                  }),
            ],
          );
        },
      )

      );

  }
}

