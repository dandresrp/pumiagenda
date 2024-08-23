import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<DocumentSnapshot<Map<String, dynamic>>> getPerfil(perfilId) async {
    return await FirebaseFirestore.instance
        .collection('perfiles')
        .doc(perfilId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inicio",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        child: FutureBuilder(
                            future: getPerfil('fUqOvARbo8CjByzoRCxD'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: LinearProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                Map<String, dynamic>? perfil =
                                    snapshot.data!.data();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      perfil!['nombre'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      perfil['carrera'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      perfil['correo'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      perfil['cuenta'].toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text('No data');
                              }
                            }),
                      ),
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.push(
                              '/editarPerfil',
                            );
                          }),
                    ],
                  ),
                ),
              ),
              const CardHorasInicio(
                ambito: "Científico/Académico",
                campoHoras: "horasAcademicas",
              ),
              const CardHorasInicio(
                ambito: "Cultural",
                campoHoras: "horasCulturales",
              ),
              const CardHorasInicio(
                ambito: "Deportivo",
                campoHoras: "horasDeportivas",
              ),
              const CardHorasInicio(
                ambito: "Social",
                campoHoras: "horasSociales",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
