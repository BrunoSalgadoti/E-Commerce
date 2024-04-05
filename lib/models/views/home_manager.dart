import 'package:brn_ecommerce/models/views/section.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # HomeManager (Folder: models/views)
///
/// A class responsible for managing home page sections and their editing state.
///
/// This class handles loading sections, adding, removing, moving sections, entering editing mode,
/// saving changes, and discarding edits for the home page.
class HomeManager extends ChangeNotifier {
  // proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Section> _sections = [];
  bool editing = false;
  bool loading = false;
  List<Section> _editingSections = [];

  // Constructor

  /// Initializes a [HomeManager] instance and loads home page sections.
  HomeManager() {
    _loadSections();
  }

  // Getters

  List<Section> get sections {
    if (editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  // Methods

  /// Loads home page sections from Firestore.
  Future<void> _loadSections() async {
    PerformanceMonitoring().startTrace('load-sections', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Starting listen Sections');
    }

    firestore.collection("home").orderBy("position").snapshots().listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
    PerformanceMonitoring().stopTrace('load-sections');
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Ending listen Sections');
    }
  }

  /// Adds a new section to the list of editing sections.
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  /// Removes a section from the list of editing sections.
  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }

  /// Moves a section up in the list of editing sections.
  void moveSectionUp(Section section) {
    final int currentIndex = _editingSections.indexOf(section);
    if (currentIndex > 0) {
      final Section previousSection = _editingSections[currentIndex - 1];
      _swapSections(section, previousSection);
      notifyListeners();
    }
  }

  /// Moves a section down in the list of editing sections.
  void moveSectionDown(Section section) {
    final int currentIndex = _editingSections.indexOf(section);
    if (currentIndex < _editingSections.length - 1) {
      final Section nextSection = _editingSections[currentIndex + 1];
      _swapSections(section, nextSection);
      notifyListeners();
    }
  }

  /// Swaps the positions of two sections in the list of editing sections.
  void _swapSections(Section section1, Section section2) {
    final int index1 = _editingSections.indexOf(section1);
    final int index2 = _editingSections.indexOf(section2);
    if (index1 != -1 && index2 != -1) {
      final Section temp = _editingSections[index1];
      _editingSections[index1] = _editingSections[index2];
      _editingSections[index2] = temp;
    }
  }

  /// Enters editing mode by cloning current sections for editing.
  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  /// Saves changes made in editing mode to Firestore.
  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) {
        valid = false;
        notifyListeners();
      }
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

  /// Discards changes made in editing mode.
  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}
