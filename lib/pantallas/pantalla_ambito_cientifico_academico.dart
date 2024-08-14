import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbitoCientificoAcademico extends StatelessWidget {
  const PantallaAmbitoCientificoAcademico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Científico/Académico'),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ActividadCard(nombre: 'Actividad XYZ', fecha: '00/00/00'),
        ],
      ),
    );
  }
}

