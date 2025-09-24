// import 'package:brn_ecommerce/models/outdoor/components/outdoor_controller.dart';
// import 'package:brn_ecommerce/views/outdoor/outdoor_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// -------------------------------
// /// Apenas para demonstração temporária.
// /// Pode ser removido facilmente quando quiser.
// /// -------------------------------
// class OutdoorDemoPreview extends StatelessWidget {
//   const OutdoorDemoPreview({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<OutdoorController>(context);
//
//     if (controller.items.isEmpty) {
//       return const Center(
//         child: Text("Nenhum outdoor disponível para demonstração."),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         const Text(
//           "Pré-visualização Temporária (somente demonstração):",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 200,
//           child: OutdoorWidget(
//             items: controller.items, // usa os outdoors já cadastrados
//             slices: 8, // fatias giratórias
//           ),
//         ),
//         const Divider(height: 30),
//       ],
//     );
//   }
// }
