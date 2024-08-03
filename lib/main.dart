import 'package:flutter/material.dart';
import 'package:pumiagenda/pantallas/pantalla_inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Inicio()
    );
  }
}
