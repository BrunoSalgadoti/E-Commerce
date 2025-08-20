import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showDrawerIcon;
  final double elevation;
  final Widget? flexibleContent;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.showDrawerIcon = true,
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
            automaticallyImplyLeading: false,
            title: null, // Everything will be managed within flexibleSpace
            flexibleSpace: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Drawer manual icon
                    if (showDrawerIcon)
                      IconButton(
                        color: getCustomAppBarColorIcons(),
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    // Centered title
                    if (title != null)
                      Expanded(
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 20,
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getCustomAppBarColorTitle(),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    // Extra flexible content (e.g. search box)
                    if (flexibleContent != null)
                      Flexible(child: flexibleContent!),
                    // Actions, respecting maxWidth
                    if (actions != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
