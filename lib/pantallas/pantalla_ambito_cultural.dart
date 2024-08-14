import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbitoCultural extends StatelessWidget {
  const PantallaAmbitoCultural({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultural'),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ActividadCard(nombre: 'Convivio carrera sistemas', fecha: '11/11/11'),
          SizedBox(height: 16.0),
          ActividadCard(nombre: 'Limpieza de areas verdes', fecha: '11/11/11'),
        ],
      ),
    );
  }
}

