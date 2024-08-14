import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbitoCientificoAcademico extends StatelessWidget {
  const PantallaAmbitoCientificoAcademico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ámbito Científico/Académico'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.0, 100.0, 40.0, 100.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Text('Hola soy ua hora VOAE'),
                      TextButton(onPressed: null, child: Text('Ver mas')),
                    ],
                  ),
                ),
              ],
            ),
          ),  
        ),
      ),
    );
  }
}

