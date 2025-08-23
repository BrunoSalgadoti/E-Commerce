import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/search/components/search_dialog.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Object? title; // can be String or Widget
  final List<Widget>? actions;
  final bool showDrawerIcon;
  final bool showSearchButton; // controls if search logic is active
  final double elevation;
  final bool? removePadding;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.showDrawerIcon,
    required this.showSearchButton,
    this.removePadding,
    this.actions,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb
            ? EdgeInsets.only(top: 0)
            : removePadding == null
                ? MediaQuery.of(context).padding
                : EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: AppBar(
            elevation: elevation,
            backgroundColor: getCustomAppBarColorBackground(),
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: null, // controlled in flexibleSpace
            flexibleSpace: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                child: Row(
                  children: [
                    // Drawer Icon
                    if (showDrawerIcon)
                      IconButton(
                        color: getCustomAppBarColorIcons(),
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      )
                    else if (Navigator.of(context).canPop())
                      IconButton(
                        color: getCustomAppBarColorIcons(),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      )
                    else
                      const SizedBox(width: 48),

                    // Title or Search
                    Expanded(
                      child: Center(
                        child: _buildDynamicTitle(context),
                      ),
                    ),

                    // Search Button
                    if (showSearchButton) _buildSearchButton(context),

                    // Additional Actions
                    if (actions != null && actions!.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      )
                    else
                      const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Centralized TextStyle for AppBar titles
  TextStyle get _titleTextStyle => TextStyle(
        color: getCustomAppBarColorTitle(),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

  /// Builds dynamic title (regular or based on ProductManager search state)
  Widget _buildDynamicTitle(BuildContext context) {
    if (!showSearchButton && title != null) {
      return _buildTitle();
    }

    return Consumer<ProductManager>(
      builder: (_, productManager, __) {
        if (productManager.search.isEmpty) {
          return productManager.filtersOn
              ? AutoSizeText("Filtro Ativo!", style: _titleTextStyle)
              : _buildTitle();
        } else {
          return GestureDetector(
            onTap: () async {
              final search = await showDialog<String>(
                context: context,
                builder: (_) => SearchDialog(
                  initialText: productManager.search,
                  hintText: "Pesquise o produto desejado...",
                ),
              );
              if (search != null) {
                productManager.search = search;
              }
            },
            child: AutoSizeText(
              productManager.search,
              maxLines: 1,
              minFontSize: 12,
              maxFontSize: 20,
              textAlign: TextAlign.center,
              style: _titleTextStyle,
            ),
          );
        }
      },
    );
  }

  /// Builds the search button (toggles search state)
  Widget _buildSearchButton(BuildContext context) {
    return Consumer<ProductManager>(
      builder: (_, productManager, __) {
        if (productManager.search.isEmpty) {
          return CustomIconButton(
            onTap: () async {
              final search = await showDialog<String>(
                context: context,
                builder: (_) => SearchDialog(
                  initialText: productManager.search,
                  hintText: "Pesquise o produto desejado...",
                ),
              );
              if (search != null) {
                productManager.search = search;
              }
            },
            iconData: Icons.search,
            size: 30,
            color: getCustomAppBarColorIcons(),
            semanticLabel: 'Search icon',
          );
        } else {
          return CustomIconButton(
            onTap: () async => productManager.search = '',
            iconData: Icons.close,
            size: 40,
            semanticLabel: 'Clear search',
          );
        }
      },
    );
  }

  /// Builds the fixed title (used when search is inactive)
  Widget _buildTitle() {
    if (title is String) {
      return AutoSizeText(
        title as String,
        maxLines: 1,
        minFontSize: 12,
        maxFontSize: 20,
        textAlign: TextAlign.center,
        style: _titleTextStyle,
      );
    } else if (title is Widget) {
      return Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: _titleTextStyle,
          child: title as Widget,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
