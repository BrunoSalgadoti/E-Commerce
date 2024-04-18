import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/home_manager.dart';
import 'package:brn_ecommerce/views/home/components/add_section_widget.dart';
import 'package:brn_ecommerce/views/home/components/section_header.dart';
import 'package:brn_ecommerce/views/home/components/section_list.dart';
import 'package:brn_ecommerce/views/home/components/section_staggered.dart';
import 'package:brn_ecommerce/views/who_we_are/who_we_are_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.sectionHeader,
  });

  final SectionHeader? sectionHeader;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: Scaffold(
            drawer: const CustomDrawer(),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [getGradientColorFirst(), getGradientColorSecond()],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 1.8, 8, 7),
                            child: Image.asset(
                              "assets/logo/storeLogo.png",
                              width: 75,
                              height: 40,
                              fit: BoxFit.fill,
                            ),
                          ),
                          //TODO: Material propaganda.
                        ],
                      ),
                    )),
                    SliverAppBar(
                      primary: false,
                      snap: true,
                      floating: true,
                      elevation: 4,
                      backgroundColor: Colors.white.withAlpha(20),
                      flexibleSpace: const FlexibleSpaceBar(),
                      actions: [
                        IconButton(
                          onPressed: () {
                            if (context.read<UserManager>().isLoggedIn) {
                              Navigator.pushNamed(context, routesNavigator.cartScreen);
                            } else {
                              Navigator.pushNamed(context, routesNavigator.loginScreen);
                            }
                          },
                          icon: Consumer<UserManager>(
                            builder: (_, userManager, __) {
                              return userManager.isLoggedIn
                                  ? const Icon(Icons.shopping_cart)
                                  : const Icon(Icons.account_circle);
                            },
                          ),
                        ),
                        Consumer2<UserManager, HomeManager>(
                          builder: (_, userManager, homeManager, __) {
                            if (userManager.adminEnable && !homeManager.loading) {
                              return homeManager.editing
                                  ? PopupMenuButton(
                                      onSelected: (e) {
                                        if (e == 'Salvar') {
                                          homeManager.saveEditing();
                                        } else {
                                          homeManager.discardEditing();
                                        }
                                      },
                                      itemBuilder: (_) {
                                        return ['Salvar', 'Descartar'].map((e) {
                                          return PopupMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList();
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: homeManager.enterEditing,
                                    );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                    Consumer<HomeManager>(
                      builder: (_, homeManager, __) {
                        if (homeManager.loading) {
                          return const SliverToBoxAdapter(
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.yellow),
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        }
                        final List<Widget> emptyPage = [const WhoWeAreScreen()];

                        final List<Widget> children = homeManager.sections.map<Widget>((section) {
                          switch (section.type) {
                            case 'List':
                              return SectionList(section: section);
                            case 'Staggered':
                              return SectionStaggered(section: section);
                            default:
                              return Container();
                          }
                        }).toList();

                        if (homeManager.editing) {
                          children.add(AddSectionWidget(
                            homeManager: homeManager,
                          ));
                        }
                        //TODO: Inserir outros widgets no layout antes do children e depois.
                        final List<Widget> bodyHome = [
                          const AdvertisingWidget(),
                          ...[
                            ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                                child: Column(children: [
                                  ...children,
                                ])),
                          ]
                        ];
                        return children.isEmpty
                            ? SliverList(delegate: SliverChildListDelegate(emptyPage))
                            : SliverList(delegate: SliverChildListDelegate(bodyHome));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
