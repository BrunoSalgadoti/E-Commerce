import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brn_ecommerce/helpers/extensions.dart';

enum StoreStatus { closed, open, closing }

class Stores {
  Stores({
    this.id,
    this.nameStore,
    this.emailStore,
    this.phoneNumberStore,
    this.imageStoreURL,
    this.openingStores,
    this.address,
  }) {
    openingStores = openingStores;
    address = address;
  }

  Stores.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nameStore = document.get("nameStore") as String? ?? "";
    emailStore = document.get("emailStore") as String? ?? "";
    phoneNumberStore = document.get("phoneNumberStore") as String? ?? "";
    imageStoreURL = document.get("imageStoreURL") as String? ?? "";
    address = Address.fromMap(document.get("address") as Map<String, dynamic>);
    openingStoresFromTimeOfDay =
        (document.get("openingStores") as Map<String, dynamic>)
            .map((key, value) {
      final timesString = value as String;

      if (timesString.isNotEmpty) {
        final splitted = timesString.split(RegExp(r"[:-]"));

        return MapEntry(key, {
          "from": TimeOfDay(
            hour: int.parse(splitted[0]),
            minute: int.parse(splitted[1]),
          ),
          "to": TimeOfDay(
            hour: int.parse(splitted[2]),
            minute: int.parse(splitted[3]),
          ),
        });
      } else {
        return MapEntry(key, null);
      }
    });
    updateStatus();
  }

  Address? address;
  OpeningStores? openingStores;

  String? id;
  String? nameStore;
  String? emailStore;
  String? phoneNumberStore;
  String? imageStoreURL;
  Map<String, Map<String, TimeOfDay>?>? openingStoresFromTimeOfDay;
  StoreStatus? status;

  String get formattedCep =>
      UtilBrasilFields.obterCep(address!.formattedZipCode);

  String get addressText => '${address?.street}, ${address?.number}'
      '${address!.complement!.isNotEmpty ? ' - ${address!.complement}' : ''} - '
      '${address?.district}, \n${address?.city}/'
      '${address?.state} - $formattedCep';

  String get openingText {
    return 'Seg-Sex: ${formattedPeriod(openingStoresFromTimeOfDay!['monFri'])}\n'
        'Sab: ${formattedPeriod(openingStoresFromTimeOfDay!['saturday'])}\n'
        'Dom: ${formattedPeriod(openingStoresFromTimeOfDay!['monday'])}';
  }

  String get cleanPhone => phoneNumberStore!.replaceAll(RegExp(r"[^\d]"), "");

  String formattedPeriod(Map<String, TimeOfDay>? period) {
    if (period == null || period.isEmpty) return 'Fechada';
    return '${period["from"]?.formatted()} - ${period["to"]?.formatted()}';
  }

  Map<String, dynamic> toMap() {
    return {
      "nameStore": nameStore,
      "emailStore": emailStore,
      "phoneNumberStore": phoneNumberStore,
      "imageStoreURL": imageStoreURL,
      "openingStores": openingStores?.toMap(),
      "address": address?.toMap(),
    };
  }

  void updateStatus() {
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay>? period;
    if (weekDay >= 1 && weekDay <= 5) {
      period = openingStoresFromTimeOfDay!["monFri"];
    } else if (weekDay == 6) {
      period = openingStoresFromTimeOfDay!["saturday"];
    } else {
      period = openingStoresFromTimeOfDay!["monday"];
    }
    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if (period["from"]!.toMinutes() < now.toMinutes() &&
        period["to"]!.toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period["from"]!.toMinutes() < now.toMinutes() &&
        period["to"]!.toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.closed:
        return 'Fechada';
      case StoreStatus.open:
        return 'Aberta';
      case StoreStatus.closing:
        return 'Fechando';
      default:
        return '';
    }
  }

  Color get colorsForStatus {
    switch (status) {
      case StoreStatus.closed:
        return Colors.red;
      case StoreStatus.open:
        return Colors.green;
      case StoreStatus.closing:
        return const Color.fromARGB(255, 210, 179, 7);
      default:
        return Colors.transparent;
    }
  }

  alertForCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Este dispositivo não suporta está função!\n'
          'O Número da Loja é : $phoneNumberStore',
          style: const TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    ));
    return;
  }

  alertForEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Este dispositivo não suporta está função!\n'
          'O E-mail da Loja é : $emailStore',
          style: const TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    ));
    return;
  }
}
