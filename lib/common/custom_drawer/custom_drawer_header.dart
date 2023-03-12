import 'package:ecommerce/models/page_manager.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
    
    class CustomDrawerHeader extends StatelessWidget {
       const CustomDrawerHeader({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
          height: 180,
          child: Consumer<UserManager>(
            builder:(_, userManager, __){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>  [
                  //TODO: Implementação da variável no gerenciamento
                   Text('Loja:\n${userManager.users?.storeName ?? 'BRN Info_Dev'}',
                    style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                      'Bem-Vindo, ${userManager.users?.userName ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(userManager.isLoggedIn){
                        userManager.signOut();
                        context.read<PageManager>().setPage(0);
                      }else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text(
                      userManager.isLoggedIn
                          ? 'Sair'
                          : 'Entre ou Cadastre-se >',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),

                    ),
                  )

                ],
              );
          }
          )
        );
      }
    }
    