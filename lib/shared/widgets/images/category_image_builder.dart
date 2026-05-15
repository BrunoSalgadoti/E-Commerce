import 'dart:io';

import 'package:brn_ecommerce/shared/constants/assets/root_assets.dart';
import 'package:brn_ecommerce/data/models/products/category/product_category.dart';
import 'package:flutter/material.dart';

Widget buildCategoryImage({required ProductCategory productCategory}) {
  final img = productCategory.categoryImg;

  if (img != null && img != "") {
    if (img is File) {
      return Image.file(img, fit: BoxFit.cover);
    } else if (img is String) {
      return Image.network(
        img,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: 30, color: Colors.grey),
          );
        },
      );
    }
  }

  return Image.asset(
    RootAssets.imageForEmptyBackgroundsJpg,
    fit: BoxFit.cover,
  );
}