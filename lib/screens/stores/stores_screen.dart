import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/models/stores_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Lojas'),
        centerTitle: true,
      ),
      body: Consumer<StoresManager> (
        builder: (_,storesManager, __) {
          return Container();
        }
      )
    );
  }
}
