import 'dart:typed_data';

import 'package:brn_ecommerce/core/control_center.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final ControlCenter _control = ControlCenter.instance;

  final MonitoringLogger _logger = MonitoringLogger();

  /// =========================
  /// ⬆️ UPLOAD FILE
  /// =========================
  Future<String> uploadFile({
    required String path,
    required dynamic file,
    int? sizeInBytes,
    String? contentType,
  }) async {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning('UPLOAD BLOCKED → $path');

      throw Exception('Upload blocked');
    }

    int fileSize = sizeInBytes ?? 0;

    try {
      fileSize = await file.length();
    } catch (_) {
      fileSize = sizeInBytes ?? 0;
    }

    // TODO(BRN): avaliar mover limite para config remota/global.
    if (fileSize > 1024 * 1024) {
      throw Exception('File too large');
    }

    final ref = _storage.ref().child(path);

    final UploadTask task = ref.putFile(
      file,
      contentType != null
          ? SettableMetadata(contentType: contentType)
          : null,
    );

    final TaskSnapshot snapshot = await task.whenComplete(() {});

    final String url = await snapshot.ref.getDownloadURL();

    _control.registerUsage(OperationType.upload);

    return url;
  }

  /// =========================
  /// ⬆️ UPLOAD DATA (WEB / UINT8LIST)
  /// =========================
  Future<String> uploadData({
    required String path,
    required Uint8List data,
    String? contentType,
  }) async {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning('UPLOAD DATA BLOCKED → $path');

      throw Exception('Upload blocked');
    }

    final int fileSize = data.lengthInBytes;

    // TODO(BRN): avaliar mover limite para config remota/global.
    if (fileSize > 1024 * 1024) {
      throw Exception('File too large');
    }

    final ref = _storage.ref().child(path);

    final UploadTask task = ref.putData(
      data,
      contentType != null
          ? SettableMetadata(contentType: contentType)
          : null,
    );

    final TaskSnapshot snapshot = await task.whenComplete(() {});

    final String url = await snapshot.ref.getDownloadURL();

    _control.registerUsage(OperationType.upload);

    return url;
  }

  /// =========================
  /// ⬇️ DOWNLOAD URL
  /// =========================
  Future<String> getDownloadUrl({
    required String path,
  }) async {
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
  /// 🗑 DELETE BY URL
  /// =========================
  Future<void> deleteByUrl(
      String url,
      ) async {
    if (!_control.canExecute(OperationType.write)) {
      _logger.logWarning('DELETE BLOCKED → $url');

      throw Exception('Delete blocked');
    }

    final ref = _storage.refFromURL(url);

    await ref.delete();

    _control.registerUsage(OperationType.write);
  }

  /// =========================
  /// 📁 GET STORAGE REFERENCE
  /// =========================
  Reference getReference({
    required String path,
  }) {
    if (!_control.canExecute(OperationType.upload)) {
      _logger.logWarning('REFERENCE BLOCKED → $path');

      throw Exception('Reference blocked');
    }

    return _storage.ref().child(path);
  }

  /// =========================
  /// 🌐 GET STORAGE REF FROM URL
  /// =========================
  Reference getReferenceFromUrl({
    required String url,
  }) {
    if (!_control.canExecute(OperationType.download)) {
      _logger.logWarning('REFERENCE URL BLOCKED');

      throw Exception('Reference blocked');
    }

    return _storage.refFromURL(url);
  }

// TODO(BRN): avaliar cache/local strategy
// para evitar downloads repetidos.
}