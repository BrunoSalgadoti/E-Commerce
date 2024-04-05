import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:brn_ecommerce/models/admin_area/configs/admin_images_controller.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/page_manager.dart';
import 'package:flutter/cupertino.dart';
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
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (const AdminAssetsController().storeLogo != null) ...[
                    const AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      minFontSize: 10,
                      maxFontSize: 20,
                      'Loja Virtual:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      const AdminAssetsController().storeLogo!,
                      height: 90,
                      fit: BoxFit.scaleDown,
                    ),
                  ] else
                    const AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      minFontSize: 10,
                      maxFontSize: 34,
                      'Loja Virtual:\n BRN Info_Dev',
                      style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                    ),
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
                        userManager.signOut();
                        context.read<PageManager>().setPage(0);
                      } else {
                        Navigator.pushNamed(context, "/login");
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
        }));
  }
}
