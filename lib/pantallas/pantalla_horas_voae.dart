import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaHorasVoae extends StatefulWidget {
  const PantallaHorasVoae({super.key});

  @override
  State<PantallaHorasVoae> createState() => _PantallaHorasVoaeState();
}

class _PantallaHorasVoaeState extends State<PantallaHorasVoae> {
  final TextEditingController nombreActividadController =
      TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController horasAcademicasController =
      TextEditingController();
  final TextEditingController horasSocialesController = TextEditingController();
  final TextEditingController horasCulturalesController =
      TextEditingController();
  final TextEditingController horasDeportivasController =
      TextEditingController();

  Future<void> addActividad(
    String nombreActividad,
    String descripcion,
    int horasAcademicas,
    int horasSociales,
    int horasCulturales,
    int horasDeportivas,
  ) {
    return FirebaseFirestore.instance.collection('actividadesvoae').add({
      'nombreActividad': nombreActividad,
      'descripcion': descripcion,
      'horasAcademicas': horasAcademicas,
      'horasSociales': horasSociales,
      'horasCulturales': horasCulturales,
      'horasDeportivas': horasDeportivas,
      'fechaActividad': Timestamp.now(),
      'fechaCreacion': Timestamp.now(),
      'fechaActualizacion': Timestamp.now(),
    });
  }

  void dialogoCrearActividad() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreActividadController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Actividad',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Descripción',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: horasAcademicasController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Horas académicas',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: horasSocialesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Horas sociales',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: horasCulturalesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Horas culturales',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: horasDeportivasController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Horas deportivas',
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              addActividad(
                nombreActividadController.text,
                descripcionController.text,
                int.parse(horasAcademicasController.text),
                int.parse(horasSocialesController.text),
                int.parse(horasCulturalesController.text),
                int.parse(horasDeportivasController.text),
              );

              nombreActividadController.clear();
              descripcionController.clear();
              horasAcademicasController.clear();
              horasSocialesController.clear();
              horasCulturalesController.clear();
              horasDeportivasController.clear();

              Navigator.pop(context);
            },
            child: const Text("Añadir"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Horas VOAE",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardHorasVoae(
                    ambito: "Científico/Academico",
                    icon: Icon(
                      Icons.description_outlined,
                      size: 30.0,
                    ),
                  ),
                  CardHorasVoae(
                    ambito: "Cultural",
                    icon: Icon(
                      Icons.temple_buddhist_outlined,
                      size: 30.0,
                    ),
                  ),
                  CardHorasVoae(
                    ambito: "Deportivo",
                    icon: Icon(
                      Icons.sports_soccer_outlined,
                      size: 30.0,
                    ),
                  ),
                  CardHorasVoae(
                    ambito: "Social",
                    icon: Icon(
                      Icons.people_outline,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: dialogoCrearActividad,
          child: const Icon(Icons.add),
        ));
  }
}
