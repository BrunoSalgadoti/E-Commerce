import 'dart:typed_data';

import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'control_center.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ControlCenter _control = ControlCenter.instance;
  final MonitoringLogger _logger = MonitoringLogger();

  /// =========================
  /// ⬆️ UPLOAD
  /// =========================
  Future<String> uploadFile({
    required String path,
    required dynamic file,
    int? sizeInBytes,
    String? contentType, // 🔥 NOVO (opcional)
  }) async {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning('UPLOAD BLOCKED → $path');
      throw Exception('Upload blocked');
    }

// =========================
// 📏 CALCULAR TAMANHO
// =========================
    int fileSize = sizeInBytes ?? 0;

    if (file is Uint8List) {
      fileSize = file.lengthInBytes;
    } else {
      try {
        fileSize = await file.length();
      } catch (_) {
        fileSize = sizeInBytes ?? 0;
      }
    }

// =========================
// 🚫 VALIDAÇÃO DE TAMANHO
// =========================
    if (fileSize > 1024 * 1024) {
      throw Exception('File too large');
    }

    final ref = _storage.ref().child(path);

    UploadTask task;

// =========================
// 🌐 WEB (Uint8List)
// =========================
    if (file is Uint8List) {
      task = ref.putData(
        file,
        contentType != null ? SettableMetadata(contentType: contentType) : null,
      );
    } else {
      // 📱 MOBILE (File)
      task = ref.putFile(
        file,
        contentType != null ? SettableMetadata(contentType: contentType) : null,
      );
    }

    final snapshot = await task;

    final url = await snapshot.ref.getDownloadURL();

    _control.registerUsage(OperationType.upload);

    return url;
  }

  /// =========================
  /// ⬇️ DOWNLOAD URL
  /// =========================
  Future<String> getDownloadUrl(String path) async {
    if (!_control.canExecute(OperationType.download)) {
      _logger.logWarning('DOWNLOAD BLOCKED → $path');
      throw Exception('Download blocked');
    }

    final ref = _storage.ref().child(path);
    final url = await ref.getDownloadURL();

    _control.registerUsage(OperationType.download);

    return url;
  }

  /// =========================
  /// 🗑 DELETE POR URL
  /// =========================
  Future<void> deleteByUrl(String url) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('DELETE BLOCKED → $url');
      throw Exception('Delete blocked');
    }

    final ref = _storage.refFromURL(url);

    await ref.delete();

    _control.registerUsage(OperationType.write);
  }
}
