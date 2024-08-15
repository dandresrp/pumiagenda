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

    Actividad actividad1 = Actividad(
      nombre: 'Convivio Sistemas',
      fecha: DateTime(2024, 8, 14),
      descripcion: 'Convivio con la carrera de ingeniería en sistemas con comida gratis para toda la carrera',
       ambitos: [
        Ambito(tipo: 'Científico/Academico', horas: 4),
        Ambito(tipo: 'Social', horas: 4),
      ],
    );

    Actividad actividad2 = Actividad(
      nombre: 'Clase de yoga',
      fecha: DateTime(2024, 8, 15),
      descripcion: 'Clase de yoga para principiantes.',
      ambitos: [
        Ambito(tipo: 'Deportivo', horas: 10),
        Ambito(tipo: 'Social', horas: 10),
      ],
    );

    Actividad actividad3 = Actividad(
      nombre: 'Juego de Futbol',
      fecha: DateTime(2024, 8, 14),
      descripcion: 'Partido de futbol entre carreras.',
      ambitos: [
        Ambito(tipo: 'Deportivo', horas: 5),
        Ambito(tipo: 'Cultural', horas: 5),
      ],
    );

    Actividades actividades = Actividades();

    // Añadir actividades a la lista
    actividades.agregarActividad(actividad1);
    actividades.agregarActividad(actividad2);
    actividades.agregarActividad(actividad3);

    String ambito = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(ambito),
        centerTitle: true,
      ),
      body:  ListView(
        padding: const EdgeInsets.all(16.0),
        children: actividades.filtrarPorAmbito(ambito).map((actividad) {
          return ActividadCard(
            nombre: actividad.nombre,
            fecha: '${actividad.fecha.day}/${actividad.fecha.month}/${actividad.fecha.year}',
          );
        }).toList(),
      ),
    );
  }
}

class Actividad {
  String nombre;
  DateTime fecha;
  String descripcion;
  List<Ambito> ambitos;

  Actividad({
    required this.nombre,
    required this.fecha,
    required this.descripcion,
    required this.ambitos,
  });
}

class Actividades {
  List<Actividad> listaActividades = [];
  Map<String, int> contadorPorAmbito = {
    'Social': 0,
    'Cultural': 0,
    'Artístico': 0,
    'Científico/Académico': 0,
  };

  // Método para añadir actividades
  void agregarActividad(Actividad actividad) {
    listaActividades.add(actividad);
    for (var ambito in actividad.ambitos) {
      if (contadorPorAmbito.containsKey(ambito.tipo)) {
        contadorPorAmbito[ambito.tipo] = contadorPorAmbito[ambito.tipo]! + ambito.horas;
      }
    }
  }

  // Método para filtrar actividades por ámbito
  List<Actividad> filtrarPorAmbito(String ambito) {
    return listaActividades.where((actividad) {
      return actividad.ambitos.any((a) => a.tipo == ambito);
    }).toList();
  }

  // Método para obtener el conteo de actividades por ámbito
  int obtenerConteoPorAmbito(String ambito) {
    return contadorPorAmbito[ambito] ?? 0;
  }
}

class Ambito {
  String tipo;
  int horas; 

  Ambito({
    required this.tipo,
    required this.horas,
  });
}