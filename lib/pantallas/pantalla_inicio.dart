import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pumiagenda/custom_widgets.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  Map<String, dynamic>? perfilEditar;
  String? profileDocId;

  @override
  void initState() {
    super.initState();
    _getProfileDocId();
  }

  Future<void> _getProfileDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileDocId = prefs.getString('profileDocId');
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPerfil(
      String perfilId) async {
    return await FirebaseFirestore.instance
        .collection('perfiles')
        .doc(perfilId)
        .get();
  }

  Icon _getIconByName(String avatar) {
    switch (avatar) {
      case 'person':
        return const Icon(Icons.person);
      case 'business':
        return const Icon(Icons.school);
      case 'healing_outlined':
        return const Icon(Icons.healing_outlined);
      case 'engineering':
        return const Icon(Icons.engineering);
      default:
        return const Icon(Icons.person);
    }
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
                      FutureBuilder(
                        future: getPerfil('$profileDocId'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircleAvatar(
                              radius: 30,
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.error),
                            );
                          } else if (snapshot.hasData) {
                            Map<String, dynamic>? perfil =
                                snapshot.data!.data();
                            perfilEditar = perfil;
                            String avatar = perfil?['avatar'] ?? 'person';

                            return CircleAvatar(
                              radius: 30,
                              child: _getIconByName(avatar),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.person),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FutureBuilder(
                          future: getPerfil('$profileDocId'),
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
                              perfilEditar = perfil;

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
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.push('/editarPerfil', extra: perfilEditar);
                        },
                      ),
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
