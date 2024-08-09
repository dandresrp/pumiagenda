import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pumiagenda/custom_widgets.dart';
class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  String nombre = 'Diego Andres Rios Pineda';
  String correo = 'driosp@unah.hn';
  String cuenta = '20212030281';
  String carrera = 'Ingenieria en Sistemas';

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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            carrera,
                            style: const TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            correo,
                            style: const TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            cuenta,
                            style: const TextStyle(
                              fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                    icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final resultado = await context.push<Map<String, String>>('/editarPerfil');
                          if (resultado != null) {
                            setState(() {
                              nombre = resultado['nombre']!;
                              correo = resultado['correo']!;
                              cuenta = resultado['cuenta']!;
                              carrera = resultado['carrera']!;
                            });
                          }
                        }
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
