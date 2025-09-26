import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/outdoor/components/outdoor_controller.dart';
import 'package:brn_ecommerce/models/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/views/outdoor/outdoor_widget.dart';
import 'package:flutter/foundation.dart';
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

    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Gerenciar Outdoors',
            showDrawerIcon: true,
            showSearchButton: false,
          ),
          drawer: CustomDrawer(),
          body: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tabletBreakpoint),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (controller.items.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: OutdoorWidget(
                        slices: 8,
                        isSilver: false,
                        controller: controller,
                      ),
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
                  ...controller.items.map(
                    (item) => ListTile(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
