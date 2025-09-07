import 'package:brn_ecommerce/helpers/route_generator.dart';
import 'package:brn_ecommerce/helpers/themes/get_theme_data.dart';
import 'package:brn_ecommerce/views/login_sing_up_screens/components/app_link_handler.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'models/users/users_manager.dart';

class BrnEcommerce extends StatefulWidget {
  const BrnEcommerce({super.key});

  @override
  State<BrnEcommerce> createState() => _BrnEcommerceState();
}

class _BrnEcommerceState extends State<BrnEcommerce> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final AppLinkHandler _appLinkHandler;

  @override
  void initState() {
    super.initState();

    // delete UserManager without listening to changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userManager = Provider.of<UserManager>(context, listen: false);
      _appLinkHandler = AppLinkHandler(
        navigatorKey: navigatorKey,
        userManager: userManager,
      );
      _appLinkHandler.init();
    });
  }

  @override
  void dispose() {
    _appLinkHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: "BRN Info_Dev - eCommerce",
      theme: getThemeData(context),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
