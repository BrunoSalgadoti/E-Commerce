import 'package:brn_ecommerce/common/sliding_up_panel/components/controller.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

Widget customSlidingUpPainel({
  required Widget? body,
  required BuildContext context,
  required Widget? childrenOfPainel,
  required Color? slidingTitleColor,
  required String? textOfSlidingUpPanel,
  List<BoxShadow>? boxShadow,
  double? borderRadiosBottomLeft,
  double? borderRadiosBottomRight,
  double? borderRadiosTopLeft,
  double? borderRadiosTopRight,
}) {
  return SlidingUpPanel(
      controller: ControlsSlidingPanel.panelController,
      boxShadow: boxShadow ??
          const [
            BoxShadow(
              blurRadius: 2.8,
              color: Color.fromRGBO(0, 0, 0, 20),
            )
          ],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadiosBottomLeft ?? 10),
        bottomRight: Radius.circular(borderRadiosBottomRight ?? 10),
        topLeft: Radius.circular(borderRadiosTopLeft ?? 0),
        topRight: Radius.circular(borderRadiosTopRight ?? 0),
      ),
      minHeight: 35,
      maxHeight: MediaQuery.of(context).size.height / 2 < 300 ? 180 : 340,
      panel: Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (ControlsSlidingPanel.panelController.isAttached) {
                        if (ControlsSlidingPanel.panelController.isPanelClosed) {
                          ControlsSlidingPanel.panelController.open();
                        } else {
                          ControlsSlidingPanel.panelController.close();
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        textOfSlidingUpPanel ?? 'F I L T R O S',
                        style: TextStyle(
                          color: slidingTitleColor ?? Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: childrenOfPainel ?? Container()),
                ],
              ))),
      body: body ?? Container());
}
