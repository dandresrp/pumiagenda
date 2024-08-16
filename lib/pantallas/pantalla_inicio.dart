import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pumiagenda/custom_widgets.dart';
import 'package:pumiagenda/models/perfil.dart';
import 'package:pumiagenda/services/database_service.dart';
// import 'package:pumiagenda/services/database_service.dart';
class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  final DatabaseService _databaseService = DatabaseService();
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
                      child: FutureBuilder(
                        future: _databaseService.getPerfil(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const LinearProgressIndicator();
                          } else {
                            Perfil perfil = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  perfil.nombre,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  perfil.carrera,
                                  style: const TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                                Text(
                                  perfil.correo,
                                  style: const TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                                Text(
                                  perfil.cuenta.toString(),
                                  style: const TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            );
                          }
                        } 
                      ),
                    ),
                    IconButton(
                    icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(
                          '/editarPerfil',
                        );
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
    );
  }
}
