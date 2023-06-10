import 'package:brn_ecommerce/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final List<Section> _sections = [];
  List<Section> _editingSections = [];

  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    firestore
        .collection('home')
        .orderBy('position')
        .snapshots()
        .listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }

  void moveSectionUp(Section section) {
    final int currentIndex = _editingSections.indexOf(section);
    if (currentIndex > 0) {
      final Section previousSection = _editingSections[currentIndex - 1];
      _swapSections(section, previousSection);
      notifyListeners();
    }
  }

  void moveSectionDown(Section section) {
    final int currentIndex = _editingSections.indexOf(section);
    if (currentIndex < _editingSections.length - 1) {
      final Section nextSection = _editingSections[currentIndex + 1];
      _swapSections(section, nextSection);
      notifyListeners();
    }
  }

  void _swapSections(Section section1, Section section2) {
    final int index1 = _editingSections.indexOf(section1);
    final int index2 = _editingSections.indexOf(section2);
    if (index1 != -1 && index2 != -1) {
      final Section temp = _editingSections[index1];
      _editingSections[index1] = _editingSections[index2];
      _editingSections[index2] = temp;
    }
  }

  List<Section> get sections {
    if (editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }
    if (!valid) return;

    loading = true;
    notifyListeners();

    int position = 0;
    for (final section in _editingSections) {
      await section.saveSection(position);
      position++;
    }

    for (final sections in List.from(_sections)) {
      if (!_editingSections.any((element) => element.id == sections.id)) {
        await sections.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}
