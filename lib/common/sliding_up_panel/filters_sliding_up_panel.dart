import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FiltersSlidingUpPanel extends StatefulWidget {
  const FiltersSlidingUpPanel({
    super.key,
    required this.textOfSlidingUpPanel,
    required this.panelController,
    required this.selectedStatus,
    this.paddingContentCheckbox,
  });

  final PanelController panelController;
  final Set<StatusOfProducts> selectedStatus;
  final String? textOfSlidingUpPanel;
  final EdgeInsetsGeometry? paddingContentCheckbox;

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
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      minHeight: 35,
      maxHeight: 340,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: StatusOfProducts.values.map((s) {
                        final isSelected = widget.selectedStatus.contains(s);

                        return Padding(
                          padding: widget.paddingContentCheckbox ??
                              const EdgeInsets.only(left: 0, right: 0),
                          child: CheckboxListTile(
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
                          ),
                        );
                      }).toList()));
            },
          )
        ],
      ),
    );
  }
}
