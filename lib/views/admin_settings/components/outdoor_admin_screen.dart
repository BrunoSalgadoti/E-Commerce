import 'package:brn_ecommerce/models/outdoor/components/outdoor_controller.dart';
import 'package:brn_ecommerce/models/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/views/outdoor/outdoor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutdoorAdminScreen extends StatefulWidget {
  const OutdoorAdminScreen({super.key});

  @override
  State<OutdoorAdminScreen> createState() => _OutdoorAdminScreenState();
}

class _OutdoorAdminScreenState extends State<OutdoorAdminScreen> {
  final TextEditingController _youtubeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<OutdoorController>(context, listen: false);
    controller.loadOutdoors();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OutdoorController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciar Outdoors")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.items.isNotEmpty)
              SizedBox(
                height: 200,
                child: OutdoorWidget(slices: 8, isSilver: false, controller: controller,),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Upload Imagem"),
              onPressed: () async {
                await controller.uploadImage();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Imagem enviada!")),
                );
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _youtubeCtrl,
              decoration: const InputDecoration(
                labelText: "Link do vídeo do YouTube",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_circle),
              label: const Text("Adicionar Vídeo"),
              onPressed: () async {
                if (_youtubeCtrl.text.isNotEmpty) {
                  await controller.addYoutube(_youtubeCtrl.text);
                  _youtubeCtrl.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vídeo adicionado!")),
                  );
                }
              },
            ),
            const Divider(height: 40),
            const Text("Outdoors Atuais:"),
            const SizedBox(height: 10),
            ...controller.items.map((item) => ListTile(
              leading: Icon(
                item.type == OutdoorType.image
                    ? Icons.image
                    : item.type == OutdoorType.asset
                    ? Icons.photo_album
                    : Icons.play_circle,
              ),
              title: Text(item.url),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await controller.deleteOutdoor(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Outdoor removido!")),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}




// import 'package:brn_ecommerce/models/outdoor/components/outdoor_controller.dart';
// import 'package:brn_ecommerce/models/outdoor/components/outdoor_item.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'outdoor_demo_preview.dart'; // Demo temporário
//
// class OutdoorAdminScreen extends StatefulWidget {
//   final bool showDemo; // Flag para mostrar demo temporária
//   const OutdoorAdminScreen({super.key, this.showDemo = false});
//
//   @override
//   State<OutdoorAdminScreen> createState() => _OutdoorAdminScreenState();
// }
//
// class _OutdoorAdminScreenState extends State<OutdoorAdminScreen> {
//   final TextEditingController _youtubeCtrl = TextEditingController();
//
//   final List<String> predefinedBackgrounds = [
//     'assets/outdoor/outdoor_bg1.jpg',
//     'assets/outdoor/outdoor_bg2.jpg',
//     'assets/outdoor/outdoor_bg3.jpg',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     final controller = Provider.of<OutdoorController>(context, listen: false);
//     controller.loadOutdoors();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<OutdoorController>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Gerenciar Outdoors")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // ----------------------------
//             // Demo temporário: apenas se flag showDemo = true
//             // ----------------------------
//             if (widget.showDemo) const OutdoorDemoPreview(),
//
//             // Upload de Imagem
//             ElevatedButton.icon(
//               icon: const Icon(Icons.image),
//               label: const Text("Upload Imagem"),
//               onPressed: () async {
//                 await controller.uploadImage();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Imagem enviada!")),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//
//             // Fundos predefinidos
//             const Text("Modelos Pré-definidos:"),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 100,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: predefinedBackgrounds.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 12),
//                 itemBuilder: (context, index) {
//                   final bg = predefinedBackgrounds[index];
//                   return GestureDetector(
//                     onTap: () async {
//                       await controller.addAsset(bg);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Modelo adicionado!")),
//                       );
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.asset(bg, width: 120, fit: BoxFit.cover),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Inserção de link do YouTube
//             TextField(
//               controller: _youtubeCtrl,
//               decoration: const InputDecoration(
//                 labelText: "Link do vídeo do YouTube",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.play_circle),
//               label: const Text("Adicionar Vídeo"),
//               onPressed: () async {
//                 if (_youtubeCtrl.text.isNotEmpty) {
//                   await controller.addYoutube(_youtubeCtrl.text);
//                   _youtubeCtrl.clear();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Vídeo adicionado!")),
//                   );
//                 }
//               },
//             ),
//             const Divider(height: 40),
//
//             // Lista de outdoors cadastrados
//             const Text("Outdoors Atuais:"),
//             const SizedBox(height: 10),
//             ...controller.items.map((item) => ListTile(
//               leading: Icon(
//                 item.type == OutdoorType.image
//                     ? Icons.image
//                     : item.type == OutdoorType.asset
//                     ? Icons.photo_album
//                     : Icons.play_circle,
//               ),
//               title: Text(item.url),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () async {
//                   await controller.deleteOutdoor(item);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Outdoor removido!")),
//                   );
//                 },
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
