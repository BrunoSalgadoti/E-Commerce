import 'dart:io';
import 'package:brn_ecommerce/common/images/root_assets.dart' show RootAssets;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustomImage extends StatelessWidget {
  final dynamic image; // can be String (url) or File
  final BoxFit fit;
  final double borderRadius;

  const ShimmerCustomImage({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _buildImage(context),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (image == null) {
      return _fallbackWidget();
    }

    if (image is String) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Image.network(
            image as String,
            fit: fit,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _shimmerPlaceholder(constraints);
            },
            errorBuilder: (context, error, stackTrace) {
              return _fallbackWidget();
            },
          );
        },
      );
    }

    if (image is File) {
      return Image.file(image as File, fit: fit);
    }

    return _fallbackWidget();
  }

  Widget _shimmerPlaceholder(BoxConstraints constraints) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Colors.black,
      ),
    );
  }

  Widget _fallbackWidget() {
    return Container(
      color: Colors.grey.shade200,
      child: Image.asset(
        RootAssets.noImagePng,
        fit: BoxFit.contain,
        color: Colors.grey, // applies a grayish tone
      ),
    );
  }
}