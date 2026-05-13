import 'dart:math';
import 'dart:ui' as ui show Image;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class SlicePainter extends CustomPainter {
  final double progress;
  final int slices;
  final ui.Image currentImage;
  final ui.Image nextImage;

  SlicePainter({
    required this.progress,
    required this.slices,
    required this.currentImage,
    required this.nextImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final sliceWidth = size.width / slices;

    for (int i = 0; i < slices; i++) {
      final left = i * sliceWidth;

      final t = ((progress * slices) - i).clamp(0.0, 1.0);
      if (t <= 0) continue;

      final currentSrc = Rect.fromLTWH(
        i * (currentImage.width / slices),
        0,
        currentImage.width / slices,
        currentImage.height.toDouble(),
      );

      final nextSrc = Rect.fromLTWH(
        i * (nextImage.width / slices),
        0,
        nextImage.width / slices,
        nextImage.height.toDouble(),
      );

      final dst = Rect.fromLTWH(left, 0, sliceWidth, size.height);

      final angle = lerpDouble(0, pi, Curves.easeInOut.transform(t))!;
      final centerX = left + sliceWidth / 2;
      final centerY = size.height / 2;

      canvas.save();
      canvas.clipRect(dst);

      final matrix = Matrix4.identity();
      matrix.translateByVector3(Vector3(centerX, centerY, 0.0));
      matrix.setEntry(3, 2, 0.0015);
      matrix.rotateY(angle);
      matrix.translateByVector3(Vector3(-centerX, -centerY, 0.0));

      canvas.transform(matrix.storage);

      if (angle <= (pi / 2)) {
        canvas.drawImageRect(currentImage, currentSrc, dst, paint);
      } else {
        final backMatrix = Matrix4.identity();
        backMatrix.translateByVector3(Vector3(centerX, centerY, 0.0));
        backMatrix.scaleByVector3(Vector3(-1.0, 1.0, 1.0));
        backMatrix.translateByVector3(Vector3(-centerX, -centerY, 0.0));

        canvas.save();
        canvas.transform(backMatrix.storage);
        canvas.drawImageRect(nextImage, nextSrc, dst, paint);
        canvas.restore();
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant SlicePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.slices != slices;
}