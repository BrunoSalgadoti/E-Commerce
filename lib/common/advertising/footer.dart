import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/models/stores/stores.dart';
import 'package:brn_ecommerce/models/stores/stores_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFooter extends StatelessWidget {
  final bool isSilver;

  const CustomFooter({super.key, this.isSilver = false});

  @override
  Widget build(BuildContext context) {
    final storesManager = Provider.of<StoresManager>(context);
    final Stores? currentStore =
        storesManager.storesList.isNotEmpty ? storesManager.storesList.first : null;

    final footerLinks = <String, VoidCallback>{
      "Comprar": () => debugPrint("Abrindo Comprar..."),
      "X": () => debugPrint("Abrindo Vender..."),
      "Facebook": () => debugPrint("Abrindo Facebook..."),
      "Instagram": () => debugPrint("Abrindo Instagram..."),
      "YouTube": () => debugPrint("Abrindo YouTube..."),
    };

    final sections = [
      _buildSection(
        "Mais informações",
        [
          "Sobre a Loja: ${currentStore?.nameStore ?? 'BRN'}",
          "Investor relations",
          "Tendências",
          "Sustentabilidade",
        ],
        onTapMap: footerLinks,
      ),
      _buildSection("Outros sites", ["Desenvolvedores", "Envios", "BRN Info_Dev"]),
      _buildSection(
        "Contato",
        ["Comprar", "Solução de problemas", "Segurança"],
        onTapMap: footerLinks,
      ),
      _buildSection("Redes sociais", ["X", "Facebook", "Instagram", "YouTube"],
          onTapMap: footerLinks),
      _buildSection("Minha conta", ["Minhas compras", "Favoritos", "Lista de desejos"]),
      _buildSection("Assinaturas",
          ["Meli+", "Disney+", "HBO Max", "Paramount+", "Universal+", "Globoplay Premium"]),
      _buildSection(
          "Temporadas", ["Dia do consumidor", "Dia das mães", "Black Friday", "descontão"]),
    ];

    final footerContent = Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;

          if (constraints.maxWidth > 1000) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 3;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.start,
                children: sections
                    .map((s) => SizedBox(
                          width: constraints.maxWidth / crossAxisCount - 32, // distributes width
                  child: s,
                        ))
                    .toList(),
              )),
              const SizedBox(height: 3),
              Divider(color: Colors.white),
              const SizedBox(height: 3),
              const AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 2,
                "Copyright © 2023-2025 - BRN - Informática e Desenvolvimento LTDA.",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 3),
              const AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 3,
                "Fale conosco | Termos e condições | Promoções | "
                "Como cuidamos da sua privacidade | Acessibilidade | "
                "Contato | Informações sobre seguros | Programa de Afiliados | Lista de presentes",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 3),
              const AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 3,
                "CNPJ n.º 52.129.576/0001-57 / Centro, nº S/N, "
                "Paulo Afonso-BA - CEP 48608-510 - produzido por: BRN Informática e Desenvolvimento.",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          );
        },
      ),
    );

    if (isSilver) {
      return SliverToBoxAdapter(child: footerContent);
    } else {
      return footerContent;
    }
  }

  Widget _buildSection(String title, List<String> items, {Map<String, VoidCallback>? onTapMap}) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            wrapWords: true,
            overflow: TextOverflow.ellipsis,
            minFontSize: 12,
            maxFontSize: 14,
            maxLines: 2,
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: InkWell(
                onTap: onTapMap != null && onTapMap.containsKey(item) ? onTapMap[item] : null,
                child: AutoSizeText(
                  wrapWords: true,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 12,
                  maxFontSize: 14,
                  maxLines: 2,
                  item,
                  style: TextStyle(
                    color: onTapMap != null && onTapMap.containsKey(item)
                        ? Colors.blueAccent
                        : Colors.white70,
                    fontSize: 12,
                    decoration: onTapMap != null && onTapMap.containsKey(item)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
