import 'package:ecommerce/screens/address/components/address_card.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          AddressCard()
        ],
      ),
    );
  }
}
