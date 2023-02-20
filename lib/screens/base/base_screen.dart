import 'package:ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:ecommerce/models/page_manager.dart';
import 'package:ecommerce/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});


  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          const ProductsScreen(),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home3'),
            ),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home4'),
            ),
          ),
          Container(color: Colors.red,),
          Container(color: Colors.yellow,),
          Container(color: Colors.green,)
        ],
      ),
    );
  }
}
