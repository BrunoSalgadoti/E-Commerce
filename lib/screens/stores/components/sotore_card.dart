import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(this.store, {super.key});

  final Stores store;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    late final alertCall = store.alertForCall(context);
    late final alertEmail = store.alertForEmail(context);
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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
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
                )
              ],
            ),
            Container(
              height: 155,
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
                          iconData: Icons.location_on,
                          color: primaryColor,
                          onTap: () {},
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
