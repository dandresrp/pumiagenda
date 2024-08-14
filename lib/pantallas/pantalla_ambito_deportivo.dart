import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbitoDeportivo extends StatelessWidget {
  const PantallaAmbitoDeportivo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deportivo'),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ActividadCard(nombre: 'Actividad Raras', fecha: '07/00/00'),
          SizedBox(height: 16.0),
          ActividadCard(nombre: 'Recoleccion de Restos', fecha: '11/11/11'),
          SizedBox(height: 16.0),
          ActividadCard(nombre: 'Convivio carrera sistemas', fecha: '11/11/11'),
        ],
      ),
    );
  }
}

