import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbito extends StatefulWidget {
  final String extrasData;
  const PantallaAmbito({super.key, required this.extrasData});
  @override
  State<PantallaAmbito> createState() => _PantallaAmbitoState();
}

class _PantallaAmbitoState extends State<PantallaAmbito> {
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

  //filtra actividades según el ámbito
  Stream<QuerySnapshot> getActividades() {
    String ambito = widget.extrasData;

    // Determinar el campo de horas en función del ámbito
    String campoHoras;
    switch (ambito) {
      case "Científico/Academico":
        campoHoras = 'horasAcademicas';
        break;
      case "Cultural":
        campoHoras = 'horasCulturales';
        break;
      case "Deportivo":
        campoHoras = 'horasDeportivas';
        break;
      case "Social":
        campoHoras = 'horasSociales';
        break;
      default:
        campoHoras = '';
    }

    //filtro en función del campo de horas
    final actividadesStream = FirebaseFirestore.instance
        .collection('perfiles')
        .doc(profileDocId)
        .collection('actividadesvoae')
        .where(campoHoras, isGreaterThan: 0)
        .snapshots();

    return actividadesStream;
  }

  @override
  Widget build(BuildContext context) {
    String ambito = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(ambito),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getActividades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            List listaActividades = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: listaActividades.length,
              itemBuilder: (context, index) {
                // Obtener cada documento
                DocumentSnapshot document = listaActividades[index];

                // Obtener Id del documento (para eliminar)
                String docId = document.id;

                // Obtener la actividad de cada documento
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String nombreActividad = data['nombreActividad'];
                Timestamp fechaActividad = data['fechaActividad'];

                // Convertir fecha a String
                Timestamp timestamp = fechaActividad;
                DateTime dateTime = timestamp.toDate();
                String formattedDate =
                    '${dateTime.day.toString().padLeft(2, '0')}/'
                    '${dateTime.month.toString().padLeft(2, '0')}/'
                    '${dateTime.year.toString().substring(2)}';

                return GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        nombreActividad,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(formattedDate),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              context.push(
                                '/editarActividad',
                                extra: {'documentId': docId, ...data},
                              );
                            },
                            child: const Text('Editar'),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              // Eliminar actividad de Firebase
                              await FirebaseFirestore.instance
                                  .collection('perfiles')
                                  .doc(profileDocId)
                                  .collection('actividadesvoae')
                                  .doc(docId)
                                  .delete();

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$nombreActividad eliminada'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Eliminar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("No hay actividades...");
          }
        },
      ),
    );
  }
}
