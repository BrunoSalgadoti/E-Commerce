import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/empty_indicator.dart';
import 'package:brn_ecommerce/models/stores_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/stores/components/sotore_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Lojas'),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnable) {
                  return IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_stores");
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        body: Consumer<StoresManager>(builder: (_, storesManager, __) {
          if (storesManager.storesList.isEmpty) {
            return const Center(
              child: EmptyIndicator(
                image: 'assets/images/await.gif',
                title: 'Carregando...',
                iconData: null,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: ListView.builder(
                itemCount: storesManager.storesList.length,
                itemBuilder: (_, index) {
                  return StoreCard(storesManager.storesList[index]);
                }),
          );
        }));
  }
}
