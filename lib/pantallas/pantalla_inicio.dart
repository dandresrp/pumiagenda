import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';
import 'package:go_router/go_router.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inicio",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 40.0, 20.0, 40.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.code),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diego Andres Rios Pineda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Ingenieria en Sistemas',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            'driosp@unah.hn',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '20212030281',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push('/editPerfil');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const CardHorasInicio(ambito: "Científico/Académico"),
            const CardHorasInicio(ambito: "Cultural"),
            const CardHorasInicio(ambito: "Deportivo"),
            const CardHorasInicio(ambito: "Social"),
          ],
        ),
      ),
      bottomNavigationBar: const BarraInferior(currentIndex: 0,),
    );
  }
}
