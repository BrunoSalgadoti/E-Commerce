import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FiltersSlidingUpPanel extends StatefulWidget {
  const FiltersSlidingUpPanel({super.key});

  @override
  State<FiltersSlidingUpPanel> createState() => _FiltersSlidingUpPanelState();
}

class _FiltersSlidingUpPanelState extends State<FiltersSlidingUpPanel> {
  final PanelController _panelController = PanelController();
  Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SlidingUpPanel(
      controller: _panelController,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      minHeight: 35,
      maxHeight: 360,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              if (_panelController.isPanelClosed) {
                _panelController.open();
              } else {
                _panelController.close();
              }
            },
            child: Container(
              height: 40,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                "F I L T R O S",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Consumer<ProductManager>(builder: (_, productManager, __) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: StatusOfProducts.values.map((s) {
                  final isSelected = selectedStatus.contains(s);

                  return CheckboxListTile(
                    title: Text(ProductManager.getStatusText(s)),
                    dense: true,
                    activeColor: primaryColor,
                    value: isSelected,
                    onChanged: (bool? v) {
                      if (v != null) {
                        setState(() {
                          if (v) {
                            if (selectedStatus.contains(s)) {
                              selectedStatus.remove(s);
                            } else {
                              selectedStatus.clear();
                              selectedStatus.add(s);
                            }
                          } else {
                            selectedStatus.remove(s);
                          }
                          productManager.setStatusFilter(
                            status: s,
                            enabled: selectedStatus.contains(s),
                          );
                        });
                        _panelController.close();
                      }
                    },
                  );
                }).toList(),
              ),
            );
          })
        ],
      ),
    );
  }
}
