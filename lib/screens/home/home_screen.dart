import 'package:ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:ecommerce/screens/home/components/section_list.dart';
import 'package:ecommerce/screens/home/components/section_staggered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(156, 141, 101, 0),
                Color.fromARGB(239, 255, 255, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Consumer<UserManager>(builder: (_, userManager, __) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
                  floating: true,
                  elevation: 4,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('BRN Info_Dev'),
                    centerTitle: true,
                  ),
                  actions: [
                    IconButton(

                      onPressed: () {
                        if (userManager.isLoggedIn) {
                          Navigator.pushNamed(context, '/cart');
                        } else {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      icon: userManager.isLoggedIn
                          ? const Icon(Icons.shopping_cart)
                          : const Icon(Icons.account_circle),
                      color: Colors.white,
                    ),
                  ],
                ),
                 Consumer<HomeManager>(
                     builder: (_, homeManager, __) {
                       final List<Widget> children = homeManager.sections
                           .map<Widget>((section) {
                             switch (section.type) {
                               case 'List':
                                 return SectionList(section: section);
                                 case 'Staggered':
                                   return SectionStaggered(section: section);
                                   default:
                                     return Container();
                    }
                       }
                       ).toList();

                       return SliverList(
                         delegate: SliverChildListDelegate(children),
                       );
                     }
                 )
              ],
            );
          })
        ],
      ),
    );
  }
}
