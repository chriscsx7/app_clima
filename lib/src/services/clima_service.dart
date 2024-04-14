import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/clima_model.dart';
import 'package:http/http.dart' as http;

class ClimaService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  ClimaService(this.apiKey);

  Future<Clima> getClima(String ciudad) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$ciudad&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Clima.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar datos del clima');
    }
  }

  Future<String> getCiudad() async {
    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    Position posicion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> coordenadas = await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    String? ciudad = coordenadas[0].locality;

    return ciudad ?? "";
  }
}