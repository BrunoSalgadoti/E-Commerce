import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:brn_ecommerce/models/stores.dart';

class StoreLocationWidget extends StatefulWidget {
  final Stores store;

  const StoreLocationWidget({Key? key, required this.store}) : super(key: key);

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

  Future<void> _openMap() async {
    try {
      final availableMap = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final map in availableMap)
                  ListTile(
                    onTap: () {
                      map.showMarker(
                        coords: Coords(_latitude, _longitude),
                        title: widget.store.nameStore!,
                        description: widget.store.addressText,
                      );
                      Navigator.pop(context);
                    },
                    title: Text(map.mapName),
                    leading: Image.asset(
                      map.icon,
                      width: 30,
                      height: 30,
                    ),
                  )
              ],
            ),
          );
        },
      );
    } catch (error) {
      widget.store.alertForMaps(context);
    }
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
              onPressed: _openMap,
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
