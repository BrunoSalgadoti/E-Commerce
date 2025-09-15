import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/advertising/best_selling_card.dart';
import 'package:brn_ecommerce/common/advertising/categories_showcase.dart';
import 'package:brn_ecommerce/common/advertising/finds_lowest_selling_showcase.dart';
import 'package:brn_ecommerce/common/advertising/footer.dart';
import 'package:brn_ecommerce/common/advertising/highlight_products_block.dart';
import 'package:brn_ecommerce/common/advertising/info_marquee_widget.dart';
import 'package:brn_ecommerce/common/advertising/purchase_suggestions_widget.dart';
import 'package:brn_ecommerce/common/advertising/recently_added_products.dart';
import 'package:brn_ecommerce/common/advertising/sales_suggestion_visited_products.dart';
import 'package:brn_ecommerce/common/app_bar/complement_app_bar.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/home_sections/home_manager.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
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
    final Widget heightSpaceBetweenWidgets = SizedBox(height: 48);

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
                            return Column(
                              children: [
                                SectionList(section: section),
                                heightSpaceBetweenWidgets,
                              ],
                            );
                          case 'Staggered':
                            return Column(
                              children: [
                                SectionStaggered(section: section),
                                heightSpaceBetweenWidgets
                              ],
                            );
                          case 'BestSelling':
                            return Column(
                              children: [const BestSellingCard(), heightSpaceBetweenWidgets],
                            );
                          case 'RecentlyAdded':
                            return ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: tabletBreakpoint),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  textForGoogleDecorations(
                                      titleForDecorations: 'Adicionados recentemente!'),
                                  const RecentlyAddedProducts(carrossel: true),
                                  heightSpaceBetweenWidgets
                                ],
                              ),
                            );

                          default:
                            return Container();
                        }
                      }).toList();

                      if (homeManager.editing) {
                        children.add(AddSectionWidget(homeManager: homeManager));
                      }

                      final List<Widget> bodyHome = [
                        const AdvertisingWidget(),
                        // --- FEATURED PRODUCTS BLOCK ---
                        Consumer<ProductManager>(
                          builder: (_, productManager, __) {
                            final List<Product> featuredProducts =
                                productManager.highlightedProducts;
                            if (featuredProducts.isEmpty) return const SizedBox.shrink();

                            // Pass isSilver = true because the HomeScreen is Silver
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: tabletBreakpoint),
                                  child: Column(
                                    children: [
                                      HighlightProductsBlock(
                                        products: featuredProducts,
                                        isSilver: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        heightSpaceBetweenWidgets,
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                          child: Column(children: [...children]),
                        ),
                        heightSpaceBetweenWidgets,
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: tabletBreakpoint),
                            child: SalesSuggestionVisitedProducts(),
                          ),
                        ),
                        heightSpaceBetweenWidgets,
                        const CategoriesShowcase(),
                        heightSpaceBetweenWidgets,
                        const FindsLowestSellingShowcase(),
                        heightSpaceBetweenWidgets,
                        PurchaseSuggestionsWidget(
                          titleText: 'Queridos entre os clientes!',
                        ),
                        heightSpaceBetweenWidgets,
                        // Positioned in the last hierarchy of home widgets
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: InfoMarqueeWidget(
                            text: AlertsMessengersText.infoMarqueeMessage,
                            color: getCustomAppBarColorBackground(),
                            fontWeight: FontWeight.w800,
                            glowColor: Colors.orange,
                            marqueeWidth: tabletBreakpoint,
                            onPressed: () {
                              context.read<PageManager>().setPage(DrawerPages.categories);
                            },
                            marqueeSpeed: MediaQuery.of(context).size.width >= 900 ? 24 : 22,
                            marqueeStart: MediaQuery.of(context).size.width >= 900 ? 1.0 : 1.7,
                            marqueeEnd: MediaQuery.of(context).size.width >= 900 ? -1.0 : -1.5,
                          ),
                        ),
                      ];

                      return children.isEmpty
                          ? SliverList(delegate: SliverChildListDelegate(emptyPage))
                          : SliverList(delegate: SliverChildListDelegate(bodyHome));
                    },
                  ),
                  CustomFooter(
                    isSilver: true,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
