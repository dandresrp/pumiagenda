import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbito extends StatefulWidget {
  final String extrasData;
  const PantallaAmbito({super.key, required this.extrasData});

  @override
  State<PantallaAmbito> createState() => _PantallaAmbitoState();
}

class _PantallaAmbitoState extends State<PantallaAmbito> {
  @override
  Widget build(BuildContext context) {
    String ambito = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(ambito),
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

