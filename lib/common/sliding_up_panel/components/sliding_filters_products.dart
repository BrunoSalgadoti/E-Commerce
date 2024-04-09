import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidingFiltersProducts extends StatefulWidget {
  final Set<StatusOfProducts> selectedStatus;

  const SlidingFiltersProducts({
    super.key,
    required this.selectedStatus,
  });

  @override
  SlidingFiltersProductsState createState() => SlidingFiltersProductsState();
}

class SlidingFiltersProductsState extends State<SlidingFiltersProducts>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Consumer<ProductManager>(
      builder: (_, productManager, __) {
        return ListView(
            itemExtent: 45,
            children: StatusOfProducts.values.map((s) {
              final isSelected = widget.selectedStatus.contains(s);
              return CheckboxListTile.adaptive(
                title: Text(ProductManager.getStatusText(s)),
                dense: true,
                activeColor: primaryColor,
                value: isSelected,
                onChanged: (bool? v) {
                  if (v != null) {
                    setState(() {
                      if (v) {
                        if (widget.selectedStatus.contains(s)) {
                          widget.selectedStatus.remove(s);
                        } else {
                          widget.selectedStatus.add(s);
                        }
                      } else {
                        widget.selectedStatus.remove(s);
                        widget.selectedStatus.clear();
                      }
                      productManager.setStatusFilter(
                        status: s,
                        enabled: widget.selectedStatus.contains(s),
                      );
                    });
                    if (productManager.filtersOn == false) {
                      widget.selectedStatus.clear();
                      widget.selectedStatus.remove(s);
                      debugPrint(productManager.filtersOn.toString());
                    }
                  }
                },
              );
            }).toList());
      },
    );
  }
}
