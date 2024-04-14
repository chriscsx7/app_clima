class Clima {
  final String ciudad;
  final double temperatura;
  final String condicion;

  Clima({
    required this.ciudad,
    required this.temperatura,
    required this.condicion,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      ciudad: json['name'],
      temperatura: json['main']['temp'].toDouble(),
      condicion: json['weather'][0]['main'],
    );
  }
}