import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PantallaEditarActividad extends StatefulWidget {
  final dynamic extrasData;
  const PantallaEditarActividad({super.key, required this.extrasData});

  @override
  State<PantallaEditarActividad> createState() =>
      _PantallaEditarActividadState();
}

class _PantallaEditarActividadState extends State<PantallaEditarActividad> {
  late String docId;
  List<String> currentPDFPaths =
      []; // CAMBIO: Lista para almacenar los paths actuales de los PDF
  List<PlatformFile> newPDFs =
      []; // CAMBIO: Lista para almacenar los nuevos PDF seleccionados

  @override
  void initState() {
    super.initState();
    docId = widget.extrasData['documentId'];

    // Verifica si 'archivosPDF' existe y no es null antes de convertirlo en una lista
    if (widget.extrasData['archivosPDF'] != null) {
      currentPDFPaths = List<String>.from(widget.extrasData['archivosPDF']);
    } else {
      currentPDFPaths = []; // Inicializa como lista vacía si es null
    }

    // Inicialización de campos
    nombreActividadController.text = widget.extrasData['nombreActividad'];
    descripcionController.text = widget.extrasData['descripcion'];
    DateTime fechaActividad = widget.extrasData['fechaActividad'].toDate();
    fechaActividadController.text =
        DateFormat('dd/MM/yyyy').format(fechaActividad);
    horasAcademicasController.text =
        widget.extrasData['horasAcademicas'].toString();
    horasCulturalesController.text =
        widget.extrasData['horasCulturales'].toString();
    horasSocialesController.text =
        widget.extrasData['horasSociales'].toString();
    horasDeportivasController.text =
        widget.extrasData['horasDeportivas'].toString();
  }

  final TextEditingController nombreActividadController =
      TextEditingController();
  final TextEditingController fechaActividadController =
      TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController horasAcademicasController =
      TextEditingController();
  final TextEditingController horasSocialesController = TextEditingController();
  final TextEditingController horasCulturalesController =
      TextEditingController();
  final TextEditingController horasDeportivasController =
      TextEditingController();

  late Timestamp fechaActividad;

  Future<void> updateActividad(
    String docId,
    String nombreActividad,
    Timestamp fechaActividad,
    String descripcion,
    int horasAcademicas,
    int horasSociales,
    int horasCulturales,
    int horasDeportivas,
    List<String> referenciasArchivosPDF,
  ) {
    return FirebaseFirestore.instance
        .collection('actividadesvoae')
        .doc(docId)
        .update(
      {
        'nombreActividad': nombreActividad,
        'descripcion': descripcion,
        'horasAcademicas': horasAcademicas,
        'horasSociales': horasSociales,
        'horasCulturales': horasCulturales,
        'horasDeportivas': horasDeportivas,
        'fechaActividad': fechaActividad,
        'fechaActualizacion': Timestamp.now(),
        'archivosPDF': referenciasArchivosPDF,
      },
    );
  }

  Future<List<String>> uploadNewPDFs(List<PlatformFile> archivos) async {
    List<String> nuevasReferencias =
        []; // CAMBIO: Lista para almacenar los paths de los nuevos PDF

    for (var archivo in archivos) {
      File file = File(archivo.path!);
      String nombreArchivo = archivo.name;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('pdfs/$nombreArchivo');

      UploadTask uploadTask = storageRef.putFile(file);
      await uploadTask;

      nuevasReferencias.add(storageRef.fullPath);
    }

    return nuevasReferencias;
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then(
      (value) {
        if (value != null) {
          setState(
            () {
              fechaActividad = Timestamp.fromDate(value);
              fechaActividadController.text =
                  DateFormat('dd/MM/yyyy').format(value);
            },
          );
        }
      },
    );
  }

  Future<List<PlatformFile>?> seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      return result.files;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Actividad'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              List<String> referencias =
                  currentPDFPaths; // CAMBIO: Inicializa con los PDF actuales

              // CAMBIO: Subir nuevos archivos PDF si se seleccionaron
              if (newPDFs.isNotEmpty) {
                referencias = await uploadNewPDFs(newPDFs);
              }

              await updateActividad(
                docId,
                nombreActividadController.text,
                fechaActividad,
                descripcionController.text,
                int.parse(horasAcademicasController.text),
                int.parse(horasSocialesController.text),
                int.parse(horasCulturalesController.text),
                int.parse(horasDeportivasController.text),
                referencias,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Actividad modificada exitosamente!'),
                  ),
                );
              }

              // Navigator.of(context)
              //     .pop(); // CAMBIO: Vuelve a la pantalla anterior tras la edición
            },
            label: const Text('Guardar cambios'),
            icon: const Icon(Icons.save),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nombreActividadController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: const Text("Nombre"),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fechaActividadController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: const Text("Fecha de la actividad"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _showDatePicker,
                    label: const Text('Elegir fecha'),
                    icon: const Icon(Icons.date_range),
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: const Text("Descripción"),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10),
                ),

                // child: const Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Ámbitos:',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //           ),
                //         )
                //       ],
                //     ),
                //     SizedBox(height: 10),
                //     // Aquí van los Checkbox con los TextField para las horas de los ámbitos, igual que en la pantalla de creación
                //   ],
                // ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(50)),
                    onPressed: () async {
                      final seleccion = await seleccionarArchivos();
                      if (seleccion != null) {
                        setState(() {
                          newPDFs.addAll(seleccion);
                        });
                      }
                    },
                    label: const Text('Subir nuevo archivo'),
                    icon: const Icon(Icons.file_upload),
                  )
                ],
              ),
              const SizedBox(height: 10),
              newPDFs.isNotEmpty
                  ? Column(
                      children: newPDFs.map((archivo) {
                        return ListTile(
                          leading: const Icon(Icons.picture_as_pdf),
                          title: Text(archivo.name),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                child: const Text('Vista previa'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    newPDFs.remove(archivo);
                                  });
                                },
                                child: const Text('Eliminar'),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : const Text('No se ha seleccionado ningún archivo nuevo'),
              const SizedBox(height: 10),
              const Text(
                'Archivos PDF actuales:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentPDFPaths.isEmpty
                  ? const Text(
                      'No hay archivos PDF asociados a esta actividad.')
                  : Column(
                      children: currentPDFPaths.map((path) {
                        return ListTile(
                          leading: const Icon(Icons.picture_as_pdf),
                          title: Text(path),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                child: const Text('Vista previa'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    currentPDFPaths.remove(path);
                                  });
                                },
                                child: const Text('Eliminar'),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
