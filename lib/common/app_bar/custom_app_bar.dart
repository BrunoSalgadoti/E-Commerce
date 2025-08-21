import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Object? title; // <-- can be String or Widget
  final List<Widget>? actions;
  final bool? showDrawerIcon;
  final double elevation;
  final Widget? flexibleContent;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    required this.showDrawerIcon,
    this.elevation = 4.0,
    this.flexibleContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: AppBar(
            elevation: elevation,
            backgroundColor: getCustomAppBarColorBackground(),
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: null, // let's control in flexibleSpace
            flexibleSpace: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                child: Row(
                  children: [
                    // Ícone do Drawer
                    if (showDrawerIcon != false)
                      IconButton(
                        color: getCustomAppBarColorIcons(),
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      )
                    else
                      const SizedBox(width: 48), // reserve space to keep the central title

                    // --- Title dinâmico ---
                    if (title != null)
                      Expanded(
                        child: Center(
                          child: _buildTitle(),
                        ),
                      ),

                    // Flexible content (ex: barra de busca)
                    if (flexibleContent != null) Flexible(child: flexibleContent!),

                    // Actions
                    if (actions != null && actions!.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      )
                    else
                      const SizedBox(width: 48), // reserves symmetrical space to the drawer
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (title is String) {
      return AutoSizeText(
        title as String,
        maxLines: 1,
        minFontSize: 12,
        maxFontSize: 20,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: getCustomAppBarColorTitle(),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    } else if (title is Widget) {
      return Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
            color: getCustomAppBarColorTitle(),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
