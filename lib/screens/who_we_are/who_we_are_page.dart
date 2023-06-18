import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/screens/who_we_are/who_we_are_screen.dart';
import 'package:flutter/material.dart';

class WhoWeArePage extends StatelessWidget {
  const WhoWeArePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.indigoAccent,
        title: const Text('Quem Somo?'),
        centerTitle: true,
      ),
      body: ListView(children: const [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [WhoWeAreScreen()]),
      ]),
      // bottomNavigationBar: const FooterDescriptionWidget(),
    );
  }
}
