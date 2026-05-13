import 'package:cloud_firestore/cloud_firestore.dart';
import '../monitoring/monitoring_logger.dart';
import '../control_center.dart';

/// 🔥 CORE GETTERS SERVICE
/// Centraliza TODOS os getters do projeto.
/// Qualquer acesso indireto ao Firebase ou dados críticos passa por aqui.
///
/// ✔ Aplica controle (ControlCenter)
/// ✔ Evita bypass silencioso
/// ✔ Escalável para outros tipos de getters (não só Firestore)
class CoreGettersService {
  CoreGettersService._internal();

  static final CoreGettersService instance = CoreGettersService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ControlCenter _control = ControlCenter.instance;
  final MonitoringLogger _logger = MonitoringLogger();

// =========================================================
// 📄 DOCUMENT REFERENCE
// =========================================================
  DocumentReference getDocumentRef({
    required String collection,
    required String docId,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('GETTER BLOCKED → DOC → $collection/$docId');
      throw Exception('Access blocked by ControlCenter');
    }


    return _firestore.collection(collection).doc(docId);


  }

// =========================================================
// 📁 COLLECTION REFERENCE
// =========================================================
  CollectionReference getCollectionRef({
    required String path,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('GETTER BLOCKED → COLLECTION → $path');
      throw Exception('Access blocked by ControlCenter');
    }

    return _firestore.collection(path);


  }

// =========================================================
// 🔮 FUTURO
// =========================================================
// Aqui você pode adicionar:
// - getters de cache
// - getters de config
// - getters de estado global
// - getters de variáveis controladas
}
