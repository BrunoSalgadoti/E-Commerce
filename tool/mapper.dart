import 'dart:io';
import 'dart:convert';

/// ----------------------HOW TO RUN ----------------------
/// flutter pub run tool/mapper.dart
/// -------------------------------------------------------
void main() async {
  final entries = <Map<String, dynamic>>[];

  final dirs = [
    Directory('lib/common'),
    Directory('lib/models'),
  ];

  for (final dir in dirs) {
    if (!dir.existsSync()) continue;

    await for (var entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = await entity.readAsString();

        // Classes
        final regexClass = RegExp(r'class\s+(\w+)', multiLine: true);
        for (final match in regexClass.allMatches(content)) {
          final nome = match.group(1)!;
          entries.add({
            'signature': nome,
            'file': entity.path,
            'type': 'class',
            'description': 'Classe presente em ${entity.path}',
          });
        }

        // Functions and methods
        final regexFun =
        RegExp(r'(?:///\s*(.*))?\s*(\w+\??\s+)?(\w+)\(([^)]*)\)', multiLine: true);

        for (final match in regexFun.allMatches(content)) {
          final description = match.group(1) ?? '';
          final retorno = match.group(2)?.trim() ?? '';
          final nome = match.group(3)?.trim() ?? '';

          String type = 'common';
          if (retorno.contains('bool')) type = 'bool';
          if (nome.startsWith('is') || nome.startsWith('has')) type = 'getter';
          if (nome.startsWith('validate') || nome.startsWith('isValid')) type = 'validation';
          if (entity.path.endsWith('common_functions.dart')) type = 'common';

          entries.add({
            'signature': '$nome(${match.group(4)})',
            'file': entity.path,
            'type': type,
            'description':
            description.isNotEmpty ? description : 'Função/método em ${entity.path}',
          });
        }
      }
    }
  }

  // Create JSON
  final jsonFile = File('mapeamento_validacoes.json');
  await jsonFile.writeAsString(json.encode({'entries': entries}));
  print('JSON gerado com ${entries.length} entries.');

  // Create MD
  final mdFile = File('mapeamento_validacoes.md');
  final buffer = StringBuffer();
  buffer.writeln('# Mapeamento de Validações e Funções\n');
  buffer.writeln('| Signature | File | Type | Description |');
  buffer.writeln('|----------|------|------|-------------|');

  for (final entry in entries) {
    buffer.writeln(
        '| ${entry['signature']} | ${entry['file']} | ${entry['type']} | ${entry['description']} |');
  }

  await mdFile.writeAsString(buffer.toString());
  print('Arquivo MD gerado: mapeamento_validacoes.md');
}
