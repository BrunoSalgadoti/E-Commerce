import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(this.store, {super.key});

  final Stores store;

  @override
  Widget build(BuildContext context) {
    //Keeping context out of async methods
    final primaryColor = Theme.of(context).primaryColor;
    late final alertCall = store.alertForCall(context);
    late final alertEmail = store.alertForEmail(context);
    closeModal() => Navigator.pop(context);
    showModalContext() => context;

    final storeImage =
        store.imageStoreURL != null && store.imageStoreURL!.isNotEmpty
            ? Image.network(store.imageStoreURL!, fit: BoxFit.cover)
            : Image.asset('assets/images/noImage.png', fit: BoxFit.cover);

    Future<void> openPhone(String phoneNumber) async {
      if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
        launchUrl(Uri.parse('tel:$phoneNumber'));
      } else {
        alertCall;
      }
    }

    Future<void> openEmail(String emailAddress) async {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
      );
      if (await canLaunchUrl(emailLaunchUri)) {
        launchUrl(emailLaunchUri);
      } else {
        alertEmail;
      }
    }

    Future<void> openMap() async {
      try {
        final availableMap = await MapLauncher.installedMaps;

        showModalBottomSheet(
          context: showModalContext(),
          builder: (_) {
            return SafeArea(
             child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final map in availableMap)
                  ListTile(
                    onTap: () {
                      map.showMarker(
                        coords:
                            Coords(store.address!.lat!, store.address!.long!),
                        title: store.nameStore!,
                        description: store.addressText,
                      );
                      closeModal();
                    },
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      width: 30,
                      height: 30,
                    ),
                  )
              ],
            ));
          },
        );
      } catch (error) {
        store.alertForMaps(context);
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: storeImage,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(9))),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: store.colorsForStatus,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Consumer<UserManager>(
                    builder: (_, userManager, __) {
                      if (userManager.adminEnable) {
                        return IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/edit_stores",
                                arguments: store);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(
                  top: 9, right: 13, left: 13, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          store.nameStore!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          store.addressText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        Text(
                          store.openingText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          iconData: Icons.map_outlined,
                          color: primaryColor,
                          onTap: () => openMap(),
                        ),
                        CustomIconButton(
                          iconData: Icons.phone,
                          color: primaryColor,
                          onTap: () => openPhone(store.cleanPhone),
                        ),
                        CustomIconButton(
                          iconData: Icons.email_outlined,
                          color: primaryColor,
                          onTap: () => openEmail(store.emailStore ?? ''),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
