class ViaCepAddress {
  final double? longitude;
  final double? latitude;
  final String cep;
  final String? streetAddress;
  final String? district;
  final String? city;
  final String? state;
  final String? ddd;
  final String? ibge;

  ViaCepAddress({
    this.longitude,
    this.latitude,
    required this.cep,
    this.streetAddress,
    this.district,
    this.city,
    this.state,
    this.ddd,
    this.ibge,
  });

  factory ViaCepAddress.fromMap(Map<String, dynamic> map, {double? latitude, double? longitude}) {
    return ViaCepAddress(
      longitude: longitude,
      latitude: latitude,
      cep: map["cep"] as String,
      streetAddress: map["logradouro"] as String? ?? "",
      district: map["bairro"] as String? ?? "",
      city: map["localidade"] as String? ?? "",
      state: map["uf"] as String? ?? "",
      ddd: map["ddd"] as String? ?? "",
      ibge: map["ibge"] as String? ?? "",
    );
  }

  @override
  String toString() {
    return 'ViaCepAddress{longitude: $longitude, latitude: $latitude, '
        'cep: $cep, streetAddress: $streetAddress, district: $district, '
        'city: $city, state: $state, ddd: $ddd, ibge: $ibge}';
  }
}
// TODO: Validar inconsistência entre ViaCEP (sem lat/long) e outras APIs

// TODO: Implementar estratégia de fallback entre APIs de CEP (ViaCEP ↔ CepAberto)
/* Objetivo:
- Utilizar múltiplas APIs para evitar bloqueio por limite de requisições
- Priorizar API gratuita (ViaCEP)
- Utilizar API secundária (CepAberto) quando necessário

Possível abordagem futura:
- Criar um CepService no core
- Centralizar lógica de escolha de API
- Normalizar resposta em um único modelo (Address)

Exemplo conceitual:
CepService.getAddress(cep):
  try ViaCEP
  fallback CepAberto

Avaliar:
- Diferença de estrutura entre APIs
- Tratamento de lat/long (nem todas fornecem)
- Cache local para reduzir chamadas externas */