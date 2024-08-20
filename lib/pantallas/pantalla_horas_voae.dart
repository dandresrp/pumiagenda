import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaHorasVoae extends StatefulWidget {
  const PantallaHorasVoae({super.key});

  @override
  State<PantallaHorasVoae> createState() => _PantallaHorasVoaeState();
}

class _PantallaHorasVoaeState extends State<PantallaHorasVoae> {
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
          onPressed: () => context.push('/nuevaActividad'),
          child: const Icon(Icons.add),
        ));
  }
}
