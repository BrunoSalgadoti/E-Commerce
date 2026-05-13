import 'dart:async';

import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'control_center.dart';

/// 🔥 FirestoreService (CORE GATEWAY)
/// Tudo que acessa Firestore DEVE passar por aqui.
/// Responsável por:
/// - Validar execução (ControlCenter)
/// - Registrar uso
/// - Controlar listeners (ponto crítico de custo)
class FirestoreService {
  // Singleton
  FirestoreService._internal();

  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ControlCenter _control = ControlCenter.instance;

  final MonitoringLogger _logger = MonitoringLogger();

  /// =========================================================
  /// 🔎 READ (get)
  /// =========================================================
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String collection,
    bool useCache = false,
  }) async {
    try {
      // =========================
      // 🔎 CACHE MODE
      // =========================
      if (useCache) {
        final result =
            await _firestore.collection(collection).get(const GetOptions(source: Source.cache));

        // ⚠️ NÃO conta como uso (sem custo)
        return result;
      }
      // =========================
      // 🌐 NETWORK MODE
      // =========================
      if (!_control.canExecute(OperationType.read)) {
        _logger.logWarning('READ BLOCKED → $collection');
        throw Exception('Read blocked by ControlCenter');
      }

      final result = await _firestore.collection(collection).get();

      _control.registerUsage(OperationType.read, amount: result.docs.length);

      return result;
    } catch (e) {
      _logger.logError('GET COLLECTION ERROR → $collection → $e');
      rethrow;
    }
  }

  /// =========================================================
  /// ✍️ WRITE
  /// =========================================================
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('WRITE BLOCKED → $collection/$docId');
      throw Exception('Write blocked by ControlCenter');
    }

    await _firestore.collection(collection).doc(docId).set(data);

    _control.registerUsage(OperationType.write);
  }

  /// =========================================================
  /// 🔄 UPDATE
  /// =========================================================
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('UPDATE BLOCKED → $collection/$docId');
      throw Exception('Update blocked by ControlCenter');
    }

    await _firestore.collection(collection).doc(docId).update(data);

    _control.registerUsage(OperationType.write);
  }

  /// =========================================================
  /// ❌ DELETE
  /// =========================================================
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('DELETE BLOCKED → $collection/$docId');
      throw Exception('Delete blocked by ControlCenter');
    }

    await _firestore.collection(collection).doc(docId).delete();

    _control.registerUsage(OperationType.write);
  }

  /// =========================================================
  /// 🔥 REALTIME LISTENER (CRÍTICO)
  /// =========================================================
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenCollection({
    required String collection,
    required void Function(QuerySnapshot<Map<String, dynamic>>) onChange,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('LISTENER BLOCKED → $collection');
      throw Exception('Listener blocked by ControlCenter');
    }

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

    subscription = _firestore.collection(collection).snapshots().listen(
      (snapshot) {
        // 🚨 1. Se já está bloqueado → nem processa
        if (_control.isBlocked()) {
          _logger.logWarning('LISTENER AUTO-CANCEL → $collection');
          subscription?.cancel();
          return;
        }

        // 🚨 2. Conta uso
        final reads = snapshot.docChanges.length;
        if (reads > 0) {
          _control.registerUsage(OperationType.read, amount: reads);
        }

        // 🚨 3. Executa lógica
        onChange(snapshot);

        // 🚨 4. Se estourou DURANTE → cancela
        if (_control.isBlocked()) {
          _logger.logWarning('LISTENER AUTO-CANCEL → $collection');
          subscription?.cancel();
        }
      },
      onError: (error) {
        _logger.logError('LISTENER ERROR → $collection → $error');
        subscription?.cancel(); // 🔥 opcional, mas recomendado
      },
    );

    return subscription;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collection,
    required String docId,
    bool useCache = false,
  }) async {
    if (useCache) {
      return await _firestore
          .collection(collection)
          .doc(docId)
          .get(const GetOptions(source: Source.cache));
    }

    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('DOC READ BLOCKED → $collection/$docId');
      throw Exception('Read blocked');
    }

    final doc = await _firestore.collection(collection).doc(docId).get();

    _control.registerUsage(OperationType.read);

    return doc;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenWithQuery({
    required Query<Map<String, dynamic>> query,
    required void Function(QuerySnapshot<Map<String, dynamic>>) onChange,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('LISTENER BLOCKED → custom query');
      throw Exception('Listener blocked by ControlCenter');
    }

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

    subscription = query.snapshots().listen(
      (snapshot) {
        if (_control.isBlocked()) {
          _logger.logWarning('LISTENER AUTO-CANCEL → custom query');
          subscription?.cancel();
          return;
        }

        final reads = snapshot.docChanges.length;
        if (reads > 0) {
          _control.registerUsage(OperationType.read, amount: reads);
        }

        onChange(snapshot);

        if (_control.isBlocked()) {
          _logger.logWarning('LISTENER AUTO-CANCEL → custom query');
          subscription?.cancel();
        }
      },
      onError: (error) {
        _logger.logError('LISTENER ERROR → custom query → $error');
        subscription?.cancel();
      },
    );

    return subscription;
  }

  Future<String> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('ADD BLOCKED → $collection');
      throw Exception('Write blocked');
    }

    final doc = await _firestore.collection(collection).add(data);

    _control.registerUsage(OperationType.write);

    return doc.id;
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> listenDocument({
    required String collection,
    required String docId,
    required void Function(DocumentSnapshot<Map<String, dynamic>>) onChange,
  }) {
    if (!_control.canExecute(OperationType.read)) {
      _logger.logWarning('DOC LISTENER BLOCKED → $collection/$docId');
      throw Exception('Listener blocked');
    }

    StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? subscription;

    subscription = _firestore
        .collection(collection)
        .doc(docId)
        .snapshots()
        .listen((doc) {
      if (_control.isBlocked()) {
        _logger.logWarning('DOC LISTENER AUTO-CANCEL → $collection/$docId');
        subscription?.cancel();
        return;
      }

      _control.registerUsage(OperationType.read);

      onChange(doc);

      if (_control.isBlocked()) {
        subscription?.cancel();
      }
    });

    return subscription;
  }

}
