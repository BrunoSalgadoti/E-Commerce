import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/section_item.dart';
import 'package:flutter/cupertino.dart';

class Section extends ChangeNotifier{

  String? name;
  String? type;
  List<SectionItem>? items;

  Section({this.name, this.type, this.items}){
   items = items ?? [];
  }

  Section.fromDocument(DocumentSnapshot document) {
    name = document.get('name') as String;
    type = document.get('type') as String;
    items = (document.get('items') as List).map(
            (i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();
  }

  void addItem(SectionItem item){
    items!.add(item);
    notifyListeners();
  }

  Section clone() {
    return Section(
      name: name,
      type: type,
      items: items?.map((e) => e.clone()).toList()
    );
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}