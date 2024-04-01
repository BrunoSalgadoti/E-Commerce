import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/views/who_we_are/who_we_are_screen.dart';
import 'package:flutter/material.dart';

class WhoWeArePage extends StatelessWidget {
  const WhoWeArePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 100, 100, 100),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Quem Somos?'),
        centerTitle: true,
      ),
      body: ListView(shrinkWrap: true, children: const [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [WhoWeAreScreen()]),
      ]),
      // bottomNavigationBar: const FooterDescriptionWidget(),
    );
  }
}
