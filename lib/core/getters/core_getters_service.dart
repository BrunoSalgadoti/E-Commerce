import 'package:brn_ecommerce/core/control_center.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// 🔥 CORE GETTERS SERVICE
///
/// Centraliza TODOS os getters críticos do projeto.
///
/// Objetivos:
/// ✔ impedir bypass silencioso
/// ✔ aplicar ControlCenter
/// ✔ padronizar referências
/// ✔ controlar acessos indiretos
///
/// IMPORTANTE:
/// Nenhuma classe deve acessar:
/// - FirebaseFirestore.instance
/// - FirebaseStorage.instance
/// diretamente fora do CORE.
class CoreGettersService {
  CoreGettersService._internal();

  static final CoreGettersService instance = CoreGettersService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final ControlCenter _control = ControlCenter.instance;

  final MonitoringLogger _logger = MonitoringLogger();

  /// =========================================================
  /// 📄 DOCUMENT REFERENCE
  /// =========================================================
  DocumentReference<Map<String, dynamic>> getDocumentRef({
    required String collection,
    required String docId,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning(
        'GETTER BLOCKED → DOC → $collection/$docId',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _firestore.collection(collection).doc(docId);
  }

  /// =========================================================
  /// 📁 COLLECTION REFERENCE
  /// =========================================================
  CollectionReference<Map<String, dynamic>> getCollectionRef({
    required String path,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning(
        'GETTER BLOCKED → COLLECTION → $path',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _firestore.collection(path);
  }

  /// =========================================================
  /// 🔎 QUERY REFERENCE
  /// =========================================================
  Query<Map<String, dynamic>> getQuery({
    required Query<Map<String, dynamic>> query,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning(
        'GETTER BLOCKED → QUERY',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return query;
  }

  /// =========================================================
  /// 📦 STORAGE REFERENCE
  /// =========================================================
  Reference getStorageRef({
    required String path,
  }) {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning(
        'GETTER BLOCKED → STORAGE → $path',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _storage.ref().child(path);
  }

  /// =========================================================
  /// 🌐 STORAGE REF FROM URL
  /// =========================================================
  Reference getStorageRefFromUrl({
    required String url,
  }) {
    if (!_control.canExecute(OperationType.download)) {
      _logger.logWarning(
        'GETTER BLOCKED → STORAGE URL',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _storage.refFromURL(url);
  }

  /// =========================================================
  /// 🧭 ROOT FIRESTORE COLLECTION
  /// =========================================================
  CollectionReference<Map<String, dynamic>> getRootCollection({
    required String collection,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning(
        'GETTER BLOCKED → ROOT COLLECTION → $collection',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _firestore.collection(collection);
  }

  /// =========================================================
  /// 🧭 ROOT STORAGE REFERENCE
  /// =========================================================
  Reference getRootStorageRef() {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning(
        'GETTER BLOCKED → ROOT STORAGE',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _storage.ref();
  }

  /// =========================================================
  /// 🔎 ORDERED COLLECTION QUERY
  /// =========================================================
  Query<Map<String, dynamic>> getOrderedCollectionQuery({
    required String collection,
    required String orderBy,
    bool descending = false,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning(
        'GETTER BLOCKED → ORDERED QUERY → $collection',
      );

      throw Exception(
        'Access blocked by ControlCenter',
      );
    }

    return _firestore.collection(collection).orderBy(
          orderBy,
          descending: descending,
        );
  }

// TODO(BRN): avaliar métricas específicas
// para getters indiretos no futuro.

// TODO(BRN): avaliar cache layer centralizada
// para referências reutilizadas.
}
