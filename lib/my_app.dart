import 'package:brn_ecommerce/helpers/route_generator.dart';
import 'package:brn_ecommerce/helpers/themes/get_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690), // Tamanho de design do seu aplicativo em dp
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        fontSizeResolver: FontSizeResolvers.width,
        builder: (ctx, child) {
          ScreenUtil.init(ctx);
          return MaterialApp(
            title: "Ecommerce BRN Info_Dev",
            theme: getThemeData(context),
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
