import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/core/getters/core_getters_service.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/data/models/home/section.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class HomeManager extends ChangeNotifier {
// =========================
// 🔧 CORE
// =========================
  final FirestoreService _firestoreService = FirestoreService.instance;

// =========================
// 📦 STATE
// =========================
  final List<Section> _sections = [];
  bool editing = false;
  bool loading = false;
  List<Section> _editingSections = [];

// =========================
// 🚀 INIT
// =========================
  HomeManager() {
    _loadSections();
  }

// =========================
// 📥 GETTERS
// =========================
  List<Section> get sections => editing ? _editingSections : _sections;

// =========================
// 🔥 LOAD (SEM BYPASS)
// =========================
  Future<void> _loadSections() async {
    PerformanceMonitoring().startTrace('load-home_sections', shouldStart: true);

    if (kDebugMode) {
      MonitoringLogger().logInfo('Starting listen Sections');
    }

// 🔥 Query modificada (orderBy preservado)
    final query = CoreGettersService.instance.getOrderedCollectionQuery(
      collection: "home",
      orderBy: "position",
    );

// 🔥 PASSA PELO CORE
    _firestoreService.listenWithQuery(
      query: query,
      onChange: (snapshot) {
        _sections.clear();

        for (final doc in snapshot.docs) {
          _sections.add(Section.fromDocument(doc));
        }

        _ensureLocalBestSellingSection();
        _ensureLocalRecentlyAddedSection();

        notifyListeners();
      },
    );

    PerformanceMonitoring().stopTrace('load-home_sections');

    if (kDebugMode) {
      MonitoringLogger().logInfo('Ending listen Sections');
    }
  }

// =========================
// 🧠 REGRAS LOCAIS
// =========================
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

// =========================
// ✏️ EDITING
// =========================
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    if (section.type == "BestSelling" || section.type == "RecentlyAdded") return;

    _editingSections.remove(section);
    notifyListeners();
  }

  void moveSectionUp(Section section) {
    final idx = _editingSections.indexOf(section);

    if (idx > 0) {
      _swapSections(section, _editingSections[idx - 1]);
      notifyListeners();
    }
  }

  void moveSectionDown(Section section) {
    final idx = _editingSections.indexOf(section);

    if (idx < _editingSections.length - 1) {
      _swapSections(section, _editingSections[idx + 1]);
      notifyListeners();
    }
  }

  void _swapSections(Section s1, Section s2) {
    final idx1 = _editingSections.indexOf(s1);
    final idx2 = _editingSections.indexOf(s2);

    if (idx1 != -1 && idx2 != -1) {
      final temp = _editingSections[idx1];
      _editingSections[idx1] = _editingSections[idx2];
      _editingSections[idx2] = temp;
    }
  }

  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

// =========================
// 💾 SAVE
// =========================
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

  void discardEditing() {
    editing = false;
    _editingSections.clear();
    notifyListeners();
  }
}
