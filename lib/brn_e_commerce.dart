import 'package:brn_ecommerce/helpers/route_generator.dart';
import 'package:brn_ecommerce/helpers/themes/get_theme_data.dart';
//Package installed in Dev_Dependencies
// ignore: depend_on_referenced_packages
import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';

class BrnEcommerce extends StatelessWidget {
  const BrnEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BRN Info_Dev - eCommerce",
      theme: getThemeData(context),
      // Adding Device Preview references.
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      // ----------------------------------
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
