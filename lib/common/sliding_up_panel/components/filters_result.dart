import 'package:brn_ecommerce/common/sliding_up_panel/components/controller.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// # Widget for displaying active filters result
/// ## filtersResult (Folder: common/sliding_up_panel/components)
/// A widget that displays the active filters result for the user to see.
///
/// This widget is used to show the active filters selected by the user. It includes
/// the name of the active filter(s) and provides an option to clear the active filters.
///
/// Returns a widget that contains the active filter(s) name and a clear button.
Widget filtersResult() {
  return Consumer<ProductManager>(builder: (_, productManager, __) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Filtro(s) Ativo(s):',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          Text(
            productManager.selectedFiltersByUser.length > 1
                ? 'Múltiplos Filtros'
                : productManager.activeFilterName ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.red,
            ),
            onPressed: () {
              productManager.disableFilter();
              ControlsSlidingPanel.panelController.close();
            },
          ),
        ],
      ),
    );
  });
}
