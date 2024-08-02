import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        title: const Text(
          "Inicio",
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BarraInferior(),
    );
  }
}
