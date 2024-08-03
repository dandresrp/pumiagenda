import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaHorasVoae extends StatelessWidget {
  const PantallaHorasVoae({super.key});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BarraInferior(currentIndex: 1,),
    );
  }
}