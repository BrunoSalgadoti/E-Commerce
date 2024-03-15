import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../helpers/breakpoints.dart';

class FiltersSlidingUpPanel extends StatefulWidget {
  const FiltersSlidingUpPanel({
    super.key,
    required this.textOfSlidingUpPanel,
    required this.panelController,
    required this.selectedStatus,
  });

  final PanelController panelController;
  final Set<StatusOfProducts> selectedStatus;
  final String? textOfSlidingUpPanel;

  @override
  FiltersSlidingUpPanelState createState() => FiltersSlidingUpPanelState();
}

class FiltersSlidingUpPanelState extends State<FiltersSlidingUpPanel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SlidingUpPanel(
      controller: widget.panelController,
      boxShadow: const [
        BoxShadow(
          blurRadius: 2.8,
          color: Color.fromRGBO(0, 0, 0, 20),
        )
      ],
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      minHeight: 35,
      maxHeight: MediaQuery.of(context).size.height / 2 < 300 ? 170 : 340,
      panel: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.panelController.isAttached) {
                    if (widget.panelController.isPanelClosed) {
                      widget.panelController.open();
                    } else {
                      widget.panelController.close();
                    }
                  }
                },
                child: Container(
                  height: 40,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.textOfSlidingUpPanel == null
                        ? 'F I L T R O S'
                        : '${widget.textOfSlidingUpPanel}',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Consumer<ProductManager>(
                builder: (_, productManager, __) {
                  return Expanded(
                      child: ListView(
                          itemExtent: 48,
                          children: StatusOfProducts.values.map((s) {
                            final isSelected = widget.selectedStatus.contains(s);
                            return CheckboxListTile(
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
                                        widget.selectedStatus.clear();
                                        widget.selectedStatus.add(s);
                                      }
                                    } else {
                                      widget.selectedStatus.remove(s);
                                    }
                                    productManager.setStatusFilter(
                                      status: s,
                                      enabled: widget.selectedStatus.contains(s),
                                    );
                                  });
                                  widget.panelController.close();
                                }
                              },
                            );
                          }).toList()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
