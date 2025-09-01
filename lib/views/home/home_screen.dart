import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/advertising/footer.dart';
import 'package:brn_ecommerce/common/app_bar/complement_app_bar.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/sections_home/home_manager.dart';
import 'package:brn_ecommerce/views/home/components/add_section_widget.dart' show AddSectionWidget;
import 'package:brn_ecommerce/views/home/components/content_home_app_bar.dart';
import 'package:brn_ecommerce/views/home/components/section_header.dart';
import 'package:brn_ecommerce/views/home/components/section_list.dart';
import 'package:brn_ecommerce/views/home/components/section_staggered.dart';
import 'package:brn_ecommerce/views/who_we_are/who_we_are_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.sectionHeader});

  final SectionHeader? sectionHeader;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: Scaffold(
          drawer: const CustomDrawer(),
          body: Stack(
            children: [
              // home gradient background
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
                  // Complement AppBar with search
                  ComplementAppBar(
                    asSliver: true,
                  ),
                  ContentHomeAppBar(),

                  // home body
                  Consumer<HomeManager>(
                    builder: (_, homeManager, __) {
                      if (homeManager.loading) {
                        return const SliverToBoxAdapter(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.orange),
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      }

                      final List<Widget> emptyPage = [const WhoWeAreScreen()];

                      // map sections
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
                        children.add(AddSectionWidget(homeManager: homeManager));
                      }

                      //TODO: Inserir outros widgets no layout antes do children e depois.

                      final List<Widget> bodyHome = [
                        const AdvertisingWidget(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                          child: Column(children: [...children]),
                        ),
                      ];

                      return children.isEmpty
                          ? SliverList(delegate: SliverChildListDelegate(emptyPage))
                          : SliverList(delegate: SliverChildListDelegate(bodyHome));
                    },
                  ),
                  CustomFooter(isSilver: true,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
