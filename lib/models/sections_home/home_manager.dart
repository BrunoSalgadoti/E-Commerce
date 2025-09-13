import 'package:brn_ecommerce/models/sections_home/section.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # HomeManager (Folder: models/views)
///
/// A class responsible for managing home page sections_home and their editing state.
///
/// This class handles loading sections_home, adding, removing, moving sections_home, entering editing mode,
/// saving changes, and discarding edits for the home page.
class HomeManager extends ChangeNotifier {
  // proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Section> _sections = [];
  bool editing = false;
  bool loading = false;
  List<Section> _editingSections = [];

  // Constructor

  /// Initializes a [HomeManager] instance and loads home page sections_home.
  HomeManager() {
    _loadSections();
  }

  // Getters

  List<Section> get sections => editing ? _editingSections : _sections;

  // Methods
  /// Loads home page sections_home from Firestore.
  Future<void> _loadSections() async {
    PerformanceMonitoring().startTrace('load-sections_home', shouldStart: true);
    if (kDebugMode) MonitoringLogger().logInfo('Starting listen Sections');

    firestore.collection("home").orderBy("position").snapshots().listen((snapshot) {
      _sections.clear();
      for (final doc in snapshot.docs) {
        _sections.add(Section.fromDocument(doc));
      }

      _ensureLocalBestSellingSection();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('load-sections_home');
    if (kDebugMode) MonitoringLogger().logInfo('Ending listen Sections');
  }

  void _ensureLocalBestSellingSection() {
    final exists = _sections.any((s) => s.type == 'BestSelling');
    if (!exists) {
      final indexToInsert = _sections.indexWhere((s) => s.type == 'List');
      _sections.insert(
        indexToInsert >= 0 ? indexToInsert + 1 : 0,
        Section(type: 'BestSelling', name: 'Mais Vendidos'),
      );
    }
  }

  /// Adds a new section to the list of editing sections_home.
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  /// Removes a section from the list of editing sections_home.
  void removeSection(Section section) {
    if (section.type == "BestSelling") return;
    _editingSections.remove(section);
    notifyListeners();
  }

  /// Moves a section up in the list of editing sections_home.
  void moveSectionUp(Section section) {
    final idx = _editingSections.indexOf(section);
    if (idx > 0) {
      _swapSections(section, _editingSections[idx - 1]);
      notifyListeners();
    }
  }

  /// Moves a section down in the list of editing sections_home.
  void moveSectionDown(Section section) {
    final idx = _editingSections.indexOf(section);
    if (idx < _editingSections.length - 1) {
      _swapSections(section, _editingSections[idx + 1]);
      notifyListeners();
    }
  }

  /// Swaps the positions of two sections_home in the list of editing sections_home.
  void _swapSections(Section s1, Section s2) {
    final idx1 = _editingSections.indexOf(s1);
    final idx2 = _editingSections.indexOf(s2);
    if (idx1 != -1 && idx2 != -1) {
      final Section temp = _editingSections[idx1];
      _editingSections[idx1] = _editingSections[idx2];
      _editingSections[idx2] = temp;
    }
  }

  /// Enters editing mode by cloning current sections_home for editing.
  void enterEditing() {
    editing = true;

    // Clone all existing sections
    _editingSections = _sections.map((s) => s.clone()).toList();

    // Ensures that BestSelling exists in the edit list
    final exists = _editingSections.any((s) => s.type == 'BestSelling');
    if (!exists) {
      // Place after the first section of type 'List' or at the beginning
      final indexToInsert = _editingSections.indexWhere((s) => s.type == 'List');
      _editingSections.insert(
        indexToInsert >= 0 ? indexToInsert + 1 : 0,
        Section(type: 'BestSelling', name: 'Mais Vendidos'),
      );
    }

    notifyListeners();
  }

  /// Saves changes made in editing mode to Firestore.
  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }
    if (!valid) {
      notifyListeners();
      return;
    }

    loading = true;
    notifyListeners();

    int position = 0;
    for (final section in _editingSections) {
      if (section.type != "BestSelling") {
        await section.saveSection(position);
      }
      position++;
    }

    for (final section in List.from(_sections)) {
      if (section.type == "BestSelling") continue;
      if (!_editingSections.any((e) => e.id == section.id)) {
        await section.delete();
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
