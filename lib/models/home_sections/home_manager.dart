import 'package:brn_ecommerce/models/home_sections/section.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # HomeManager (Folder: models/views)
///
/// A class responsible for managing home page home_sections and their editing state.
///
/// This class handles loading home_sections, adding, removing, moving home_sections, entering editing mode,
/// saving changes, and discarding edits for the home page.
class HomeManager extends ChangeNotifier {
  // proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Section> _sections = [];
  bool editing = false;
  bool loading = false;
  List<Section> _editingSections = [];

  // Constructor

  /// Initializes a [HomeManager] instance and loads home page home_sections.
  HomeManager() {
    _loadSections();
  }

  // Getters

  List<Section> get sections => editing ? _editingSections : _sections;

  // Methods
  /// Loads home page home_sections from Firestore.
  Future<void> _loadSections() async {
    PerformanceMonitoring().startTrace('load-home_sections', shouldStart: true);
    if (kDebugMode) MonitoringLogger().logInfo('Starting listen Sections');

    firestore.collection("home").orderBy("position").snapshots().listen((snapshot) {
      _sections.clear();
      for (final doc in snapshot.docs) {
        _sections.add(Section.fromDocument(doc));
      }

      _ensureLocalBestSellingSection();
      _ensureLocalRecentlyAddedSection();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('load-home_sections');
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

  void _ensureLocalRecentlyAddedSection() {
    final exists = _sections.any((s) => s.type == 'RecentlyAdded');
    if (!exists) {
      final indexToInsert = _sections.indexWhere((s) => s.type == 'List');
      _sections.insert(
        indexToInsert >= 0 ? indexToInsert + 4 : 0,
        Section(type: 'RecentlyAdded', name: 'Adicionados Recentemente'),
      );
    }
  }

  /// Adds a new section to the list of editing home_sections.
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  /// Removes a section from the list of editing home_sections.
  void removeSection(Section section) {
    if (section.type == "BestSelling" || section.type == "RecentlyAdded") return;
    _editingSections.remove(section);
    notifyListeners();
  }

  /// Moves a section up in the list of editing home_sections.
  void moveSectionUp(Section section) {
    final idx = _editingSections.indexOf(section);
    if (idx > 0) {
      _swapSections(section, _editingSections[idx - 1]);
      notifyListeners();
    }
  }

  /// Moves a section down in the list of editing home_sections.
  void moveSectionDown(Section section) {
    final idx = _editingSections.indexOf(section);
    if (idx < _editingSections.length - 1) {
      _swapSections(section, _editingSections[idx + 1]);
      notifyListeners();
    }
  }

  /// Swaps the positions of two home_sections in the list of editing home_sections.
  void _swapSections(Section s1, Section s2) {
    final idx1 = _editingSections.indexOf(s1);
    final idx2 = _editingSections.indexOf(s2);
    if (idx1 != -1 && idx2 != -1) {
      final Section temp = _editingSections[idx1];
      _editingSections[idx1] = _editingSections[idx2];
      _editingSections[idx2] = temp;
    }
  }

  /// Enters editing mode by cloning current home_sections for editing.
  void enterEditing() {
    editing = true;

    // Clone all existing sections
    _editingSections = _sections.map((s) => s.clone()).toList();
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
      if (section.type != "BestSelling" || section.type != "RecentlyAdded") {
        await section.saveSection(position);
      }
      position++;
    }

    for (final section in List.from(_sections)) {
      if (section.type == "BestSelling" || section.type == "RecentlyAdded") continue;
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
    _editingSections.clear();
    notifyListeners();
  }
}
