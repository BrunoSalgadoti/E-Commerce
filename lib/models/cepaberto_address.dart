class CepAbertoAddress {
  final double? altitude;
  final double? latitude;
  final String? longitude;
  final String cep;
  final String? logradouro;
  final String? bairro;
  final Cidade? cidade;
  final Estado? estado;

  CepAbertoAddress.fromMap(Map<String, dynamic> map)
      : altitude = map['altitude'] as double? ?? 0.0,
        latitude = double.tryParse(map['latitude'] as String? ?? ''),
        longitude = map['longitude'] as String? ?? '',
        cep = map['cep'] as String,
        logradouro = map['logradouro'] as String? ?? '',
        bairro = map['bairro'] as String? ?? '',
        cidade = Cidade.fromMap(map['cidade'] as Map<String, dynamic>),
        estado = Estado.fromMap(map['estado'] as Map<String, dynamic>);

  @override
  String toString() {
    return 'CepAbertoAddress{altitude: $altitude, '
        'latitude: $latitude, logitude: $longitude, cep: $cep, '
        'logradouro: $logradouro, bairro: $bairro, cidade: $cidade, '
        'estado: $estado}';
  }
}

class Cidade {
  final int ddd;
  final String ibge;
  final String nome;

  Cidade.fromMap(Map<String, dynamic> map)
      : ddd = map['ddd'] as int? ?? 0,
        ibge = map['ibge'] as String? ?? '',
        nome = map['nome'] as String? ?? '';

  @override
  String toString() {
    return 'Cidade{ddd: $ddd, ibge: $ibge, nome: $nome}';
  }
}

class Estado {
  final String sigla;

  Estado.fromMap(Map<String, dynamic> map)
      : sigla = map['sigla'] as String? ?? '';

  @override
  String toString() {
    return 'Estado{sigla: $sigla}';
  }
}
