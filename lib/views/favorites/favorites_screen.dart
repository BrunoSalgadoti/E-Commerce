import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/cards/login_card.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/models/favorites/favorites_manager.dart';
import 'package:brn_ecommerce/models/sales/orders_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritosManager = Provider.of<FavoritesManager>(context);
    final favoritos = favoritosManager.favoritos;
    final ordersManager =  Provider.of<OrdersManager>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favoritos',
        showDrawerIcon: true,
        showSearchButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // Criar lista de presentes
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: ordersManager.users!.id == null ? LoginCard()
          : favoritos.isEmpty
          ? const Center(
              child: Text("Você ainda não tem favoritos."),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favoritos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final produto = favoritos[index];
                return Card(
                  child: ListTile(
                    leading: produto.images?.first != null
                        ? Image.network(produto.images!.first, width: 50, height: 50)
                        : const SizedBox(width: 50, height: 50),
                    title: Text(produto.name ?? 'Sem nome'),
                    subtitle: Text("R\$ ${produto.details?.price?.toStringAsFixed(2) ?? '----'}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.playlist_add),
                          onPressed: () {
                            // Adicionar à lista de presentes
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            favoritosManager.removeFavorite(produto);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
