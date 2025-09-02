import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## CustomDrawerHeader (Folder: common/drawer/components)
/// ### Components of Drawer Widget
/// A custom header to be used in the application's Drawer.
class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
      height: 200,
      child: Consumer2<UserManager, PageManager>(
        builder: (_, userManager, pageManager, __) {
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const AutoSizeText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    minFontSize: 10,
                    maxFontSize: 20,
                    'Loja Virtual:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      child: Image.asset(
                        RootAssets.storeImgLogo,
                        height: 90,
                        fit: BoxFit.scaleDown,
                      ),
                      onTap: () => pageManager.setPage(DrawerPages.home)),
                  AutoSizeText(
                    'Bem-Vindo(a)! ${userManager.users?.userName ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    minFontSize: 10,
                    maxFontSize: 18,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      if (userManager.isLoggedIn) {
                        userManager.signOut(context);
                        pageManager.setPage(DrawerPages.home);
                      } else {
                        Navigator.pushNamed(context, RoutesNavigator.loginScreen);
                      }
                    },
                    child: AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 16,
                      userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se >',
                      style: TextStyle(
                          color: getEspecialColor(), fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
