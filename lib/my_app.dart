import 'package:brn_ecommerce/helpers/route_generator.dart';
import 'package:brn_ecommerce/helpers/themes/get_theme_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loja Virtual BRN-Info_Dev",
      theme: getThemeData(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
