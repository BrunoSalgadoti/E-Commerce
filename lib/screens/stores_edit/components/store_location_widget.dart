import 'package:brn_ecommerce/models/stores.dart';
import 'package:brn_ecommerce/screens/stores/components/store_utils.dart';
import 'package:flutter/material.dart';

class StoreLocationWidget extends StatefulWidget {
  const StoreLocationWidget({Key? key, required this.store}) : super(key: key);

  final Stores store;

  @override
  StoreLocationWidgetState createState() => StoreLocationWidgetState();
}

class StoreLocationWidgetState extends State<StoreLocationWidget> {
  // Variables to hold latitude and longitude
  late double _latitude;
  late double _longitude;

  @override
  void initState() {
    super.initState();
    _latitude = widget.store.address?.lat ?? 0;
    _longitude = widget.store.address?.long ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Localização atual desta Loja:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: () => StoreUtils(
                store: widget.store,
                address: widget.store.address!,
              ).openMap(context, _latitude, _longitude),
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Latitude: $_latitude\nLongitude: $_longitude',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
