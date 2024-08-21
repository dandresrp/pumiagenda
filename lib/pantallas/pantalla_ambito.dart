import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:pumiagenda/custom_widgets.dart';

class PantallaAmbito extends StatefulWidget {
  final String extrasData;
  const PantallaAmbito({super.key, required this.extrasData});
  @override
  State<PantallaAmbito> createState() => _PantallaAmbitoState();
}

class _PantallaAmbitoState extends State<PantallaAmbito> {
  Stream<QuerySnapshot> getActividades() {
    final actividadesStream =
        FirebaseFirestore.instance.collection('actividadesvoae').snapshots();
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

                //Obtener Id del documento (para eliminar)
                String docId = document.id;

                // Obtener la actividad de cada documento
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String nombreActividad = data['nombreActividad'];
                 Timestamp fechaActividad = data['fechaActividad'];

                //Convertir fecha a String
                Timestamp timestamp = fechaActividad; 
                DateTime dateTime = timestamp.toDate();
                String formattedDate = '${dateTime.day.toString().padLeft(2, '0')}/'
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
                          fontSize: 16, fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Text(formattedDate),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                context.push(
                                  '/horasVoae',
                                );
                              },  
                              child: const Text('Editar'),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () async {
                                // Eliminar actividad de Firebase
                                await FirebaseFirestore.instance
                                    .collection('actividadesvoae')
                                    .doc(docId)
                                    .delete();
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$nombreActividad eliminada'),
                                  ),
                                );
                              },

                              // onPressed: () {
                              //   context.push(
                              //     '/horasVoae',
                              //   );
                              //   //eliminar actividad 

                              // },  
                              
                              child: const Text('Eliminar'),
                            ),
                          ),
                        ]) 
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      //PopupMenuButton(
                      //   itemBuilder: (context) => [
                      //     PopupMenuItem(
                      //       child: TextButton(
                      //         onPressed: () {
                      //           context.push(
                      //             '/horasVoae',
                      //           );
                      //         },  
                      //         child: const Text('Editar'),
                      //       ),
                      //     ),
                      //     PopupMenuItem(
                      //       child: TextButton(
                      //         onPressed: () async {
                      //           // Eliminar actividad de Firebase
                      //           await FirebaseFirestore.instance
                      //               .collection('actividadesvoae')
                      //               .doc(docId)
                      //               .delete();
                      //             // ignore: use_build_context_synchronously
                      //             ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(
                      //               content: Text('$nombreActividad eliminada'),
                      //             ),
                      //           );
                      //         },
                      //         child: const Text('Eliminar'),
                      //       ),
                      //       onTap: () {
                      //         Navigator.pushNamed(context, '/inicio');
                      //       }, 
                      //     ),
                      //   ])
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

// class Actividad {
//   String nombre;
//   DateTime fecha;
//   String descripcion;
//   List<Ambito> ambitos;

//   Actividad({
//     required this.nombre,
//     required this.fecha,
//     required this.descripcion,
//     required this.ambitos,
//   });
// }

// class Actividades {
//   List<Actividad> listaActividades = [];
//   Map<String, int> contadorPorAmbito = {
//     'Social': 0,
//     'Cultural': 0,
//     'Artístico': 0,
//     'Científico/Académico': 0,
//   };

//   // Método para añadir actividades
//   void agregarActividad(Actividad actividad) {
//     listaActividades.add(actividad);
//     for (var ambito in actividad.ambitos) {
//       if (contadorPorAmbito.containsKey(ambito.tipo)) {
//         contadorPorAmbito[ambito.tipo] =
//             contadorPorAmbito[ambito.tipo]! + ambito.horas;
//       }
//     }
//   }

//   // Método para filtrar actividades por ámbito
//   List<Actividad> filtrarPorAmbito(String ambito) {
//     return listaActividades.where((actividad) {
//       return actividad.ambitos.any((a) => a.tipo == ambito);
//     }).toList();
//   }

//   // Método para obtener el conteo de actividades por ámbito
//   int obtenerConteoPorAmbito(String ambito) {
//     return contadorPorAmbito[ambito] ?? 0;
//   }
// }

// class Ambito {
//   String tipo;
//   int horas;

//   Ambito({
//     required this.tipo,
//     required this.horas,
//   });
// }
