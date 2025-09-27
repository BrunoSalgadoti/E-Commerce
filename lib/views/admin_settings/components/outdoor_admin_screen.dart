import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/outdoor/components/outdoor_controller.dart';
import 'package:brn_ecommerce/common/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/common/outdoor/outdoor_widget.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product.dart';
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

  // Assets fixos para fundos
  final List<String> _assetBackgrounds = [
    RootAssets.outdoorImage1Jpg,
    RootAssets.outdoorImage2Jpg,
    RootAssets.outdoorImage3Jpg,
  ];

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<OutdoorController>(context, listen: false);
    controller.loadOutdoors();
  }

  Future<void> _selectAsset(BuildContext context, String assetPath) async {
    final controller = Provider.of<OutdoorController>(context, listen: false);

    // Popup para escolher produto
    final Product? selectedProduct = await showDialog<Product>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Vincule um produto!"),
          content: const Text("Selecione o produto para este fundo."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                final selectedProduct = await Navigator.pushNamed(
                  context,
                  RoutesNavigator.selectProductScreen,
                  arguments: Product(),
                ) as Product?;
                Navigator.pop(context, selectedProduct);
              },
              child: const Text("Selecionar Produto"),
            ),
          ],
        );
      },
    );

    if (selectedProduct != null) {
      // Cria o OutdoorItem do tipo asset vinculado ao produto
      final newItem = OutdoorItem(
        id: '',
        url: assetPath,
        type: OutdoorType.asset,
        productId: selectedProduct.id, // vincula o produto
      );
      await controller.addOutdoor(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fundo adicionado com produto vinculado!")),
      );
    }
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
                  const Text("Fundos predefinidos:"),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _assetBackgrounds.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final asset = _assetBackgrounds[index];
                      return GestureDetector(
                        onTap: () => _selectAsset(context, asset),
                        child: Card(
                          child: Image.asset(asset, fit: BoxFit.cover),
                        ),
                      );
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
                            const SnackBar(content: Text("Um componente removido!")),
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
