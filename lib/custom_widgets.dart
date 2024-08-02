import 'package:flutter/material.dart';

class BarraInferior extends StatelessWidget {
  const BarraInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Horas VOAE",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configuración",
          ),
        ],
    );
  }
}