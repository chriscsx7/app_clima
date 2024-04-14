import 'package:app_clima/src/models/clima_model.dart';
import 'package:app_clima/src/services/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {

  final _climaService = ClimaService('bab6cfc9be1a6352e774c1b71be35e77');
  Clima? _clima;

  _fetchClima() async {
    String ciudad = await _climaService.getCiudad();

    try {
      final clima = await _climaService.getClima(ciudad);
      setState(() {
        _clima = clima;
      });
    } catch (e) {
      print(e);
    }
  }

  String getAnimacion(String? condicion) {
    if (condicion == null) return 'assets/sunny.json';

    switch (condicion.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClima();
  }

  @override
  Widget build(BuildContext context) {
    if (_clima?.ciudad == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Clima App'),
        ),
        backgroundColor: Colors.white,
        body: const Center(
          child: CircularProgressIndicator()
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_clima?.ciudad ?? "Cargando ciudad..."),
            Lottie.asset(getAnimacion(_clima?.condicion)),
            Text('${_clima?.temperatura.round().toString()}°C'),
            Text(_clima?.condicion ?? "")
          ],
        ),
      ),
    );
  }
}