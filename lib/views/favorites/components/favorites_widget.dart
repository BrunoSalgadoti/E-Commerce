import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/favorites/favorites_manager.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesWidget extends StatelessWidget {
  final Product product;

  const FavoritesWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavoritesManager, UserManager>(
      builder: (_, favoritesManager, userManager, __) {
        final bool isLoggedIn = userManager.isLoggedIn;
        final bool isFav = isLoggedIn && favoritesManager.isFavorite(product);

        return CustomIconButton(
          iconData: isFav ? Icons.favorite : Icons.favorite_border,
          semanticLabel: 'Meus Favoritos',
          color: Colors.red,
          size: 33,
          onTap: () {
            if (!isLoggedIn) {
              // If not logged in → show popup
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Login necessário'),
                  content: const Text(
                    'Você precisa estar logado para adicionar favoritos. Deseja fazer login agora?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).pushNamed(RoutesNavigator.loginScreen);
                      },
                      child: const Text('Fazer login'),
                    ),
                  ],
                ),
              );
              return;
            }
            // If logged in → toggle favorite
            if (favoritesManager.isFavorite(product)) {
              favoritesManager.removeFavorite(product);
            } else {
              favoritesManager.addFavorite(product);
            }
          },
        );
      },
    );
  }
}
