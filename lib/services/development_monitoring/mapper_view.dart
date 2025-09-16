import 'dart:convert';
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Returns null in release
Widget? getMapperView() {
  if (!kDebugMode) return null;
  return const _MapperViewWrapper();
}

class _MapperViewWrapper extends StatefulWidget {
  const _MapperViewWrapper();

  @override
  State<_MapperViewWrapper> createState() => _MapperViewWrapperState();
}

class _MapperViewWrapperState extends State<_MapperViewWrapper> {
  List<dynamic> entries = [];
  List<dynamic> filtered = [];
  String filterCurrent = 'todos';
  String search = '';
  Map<String, List<Map<String, String>>> duplicateDetails = {};

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final jsonString = await rootBundle.loadString('mapeamento_validacoes.json');
    final data = json.decode(jsonString);
    setState(() {
      entries = data['entries'] ?? [];
      _identifyDuplicates();
      _applyFilter();
    });
  }

  void _identifyDuplicates() {
    final names = <String>{};
    duplicateDetails.clear();

    for (var e in entries) {
      final name = e['signature'] ?? '';
      final type = e['type'] ?? '';
      final file = e['file'] ?? '';

      if (names.contains(name)) {
        duplicateDetails.putIfAbsent(name, () => []);
        duplicateDetails[name]!.add({'file': file, 'type': type});
      } else {
        names.add(name);
        duplicateDetails[name] = [
          {'file': file, 'type': type}
        ];
      }
    }

    // only keeps duplicates in fact
    duplicateDetails.removeWhere((_, list) => list.length < 2);
  }

  void _applyFilter() {
    filtered = entries.where((e) {
      final matchType = filterCurrent == 'todos' || e['type'] == filterCurrent;
      final matchSearch =
          search.isEmpty || (e['signature']?.toLowerCase().contains(search.toLowerCase()) ?? false);
      return matchType && matchSearch;
    }).toList();

    _sortList();
  }

  void _sortList() {
    final orderType = {'bool': 0, 'getter': 1, 'validation': 2, 'common': 3, 'class': 4};
    filtered.sort((a, b) {
      final typeA = orderType[a['type']] ?? 5;
      final typeB = orderType[b['type']] ?? 5;
      if (typeA != typeB) return typeA.compareTo(typeB);
      final nomeA = a['signature'] ?? '';
      final nomeB = b['signature'] ?? '';
      return nomeA.compareTo(nomeB);
    });
  }

  Future<void> _printPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, child: pw.Text('Mapeamento de Estruturas')),
          pw.Text('Total entries: ${entries.length}'),
          pw.Text('Filtradas: ${filtered.length}'),
          pw.SizedBox(height: 10),
          ...filtered.map((item) {
            final nome = item['signature'] ?? '';
            final file = item['file'] ?? '';
            final type = item['type'] ?? '';
            final description = item['description'] ?? '';
            final isDup = duplicateDetails.containsKey(nome);

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '[$type] $nome',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: isDup ? PdfColors.red : PdfColors.black,
                    fontWeight: isDup ? pw.FontWeight.bold : pw.FontWeight.normal,
                  ),
                ),
                pw.Text('Arquivo: $file',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                if (description.isNotEmpty)
                  pw.Text(description,
                      style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),
                if (isDup)
                  pw.Text(
                    'Duplicado em: ${duplicateDetails[nome]!.map((d) => d['file']).join(", ")}',
                    style: const pw.TextStyle(fontSize: 9, color: PdfColors.red),
                  ),
                pw.SizedBox(height: 5),
              ],
            );
          }),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mapeamento de Estruturas',
        showDrawerIcon: false,
        showSearchButton: false,
        actions: [
          IconButton(icon: const Icon(Icons.print), tooltip: 'Imprimir PDF', onPressed: _printPDF),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filterCurrent = value;
                _applyFilter();
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'todos', child: Text('Todos')),
              PopupMenuItem(value: 'bool', child: Text('Bools')),
              PopupMenuItem(value: 'getter', child: Text('Getters')),
              PopupMenuItem(value: 'validation', child: Text('Validações')),
              PopupMenuItem(value: 'common', child: Text('Commons')),
              PopupMenuItem(value: 'class', child: Text('Classes')),
            ],
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: tabletBreakpoint),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                      _applyFilter();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total entries: ${entries.length}'),
                    Text('Filtradas: ${filtered.length}'),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final nome = item['signature'] ?? '';
                          final isDup = duplicateDetails.containsKey(nome);
                          return Card(
                            color: isDup ? Colors.red[50] : null,
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ListTile(
                              title: Text(
                                nome,
                                style: TextStyle(
                                  fontWeight: isDup ? FontWeight.bold : FontWeight.normal,
                                  color: isDup ? Colors.red : null,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['file'] ?? ''),
                                  if (item['description'] != null &&
                                      item['description']!.isNotEmpty)
                                    Text(
                                      item['description']!,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic, fontSize: 12),
                                    ),
                                ],
                              ),
                              leading: Icon(
                                _iconByType(item['type']),
                                color: Colors.blueAccent,
                              ),
                              trailing: isDup
                                  ? PopupMenuButton(
                                      icon: const Icon(Icons.warning, color: Colors.red),
                                      itemBuilder: (context) {
                                        return duplicateDetails[nome]!.map((d) {
                                          return PopupMenuItem(
                                            child: Text("${d['type']} - ${d['file']}"),
                                          );
                                        }).toList();
                                      },
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconByType(String? type) {
    switch (type) {
      case 'bool':
        return Icons.toggle_on;
      case 'getter':
        return Icons.call_made;
      case 'validation':
        return Icons.check_circle_outline;
      case 'common':
        return Icons.functions;
      case 'class':
        return Icons.class_;
      default:
        return Icons.code;
    }
  }
}
