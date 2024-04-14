import 'package:flutter/material.dart';
import 'package:app_clima/src/pages/clima_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const ClimaPage(),
    );
  }
}