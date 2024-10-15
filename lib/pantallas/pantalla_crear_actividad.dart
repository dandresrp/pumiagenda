import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class NuevaActividad extends StatefulWidget {
  const NuevaActividad({super.key});

  @override
  State<NuevaActividad> createState() => _NuevaActividadState();
}

class _NuevaActividadState extends State<NuevaActividad> {
  final _formKey = GlobalKey<FormState>();
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
  String? profileDocId;

  bool academicoIsChecked = false;
  bool socialIsChecked = false;
  bool culturalIsChecked = false;
  bool deportivoIsChecked = false;
  Timestamp? fechaActividad;
  List<PlatformFile> archivos = [];

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

  Future<List<Reference>> subirArchivos(List<PlatformFile> archivos) async {
    List<Reference> referencias = [];

    for (var archivo in archivos) {
      File file = File(archivo.path!);
      String nombreArchivo = archivo.name;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('pdfs/$nombreArchivo');

      UploadTask uploadTask = storageRef.putFile(file);

      await uploadTask;

      referencias.add(storageRef);
    }

    return referencias;
  }

  Future<void> addActividad(
    String nombreActividad,
    Timestamp? fechaActividad,
    String? descripcion,
    int? horasAcademicas,
    int? horasSociales,
    int? horasCulturales,
    int? horasDeportivas,
    List<Reference> referenciasArchivosPDF,
  ) {
    List<String> pathsArchivosPDF =
        referenciasArchivosPDF.map((ref) => ref.fullPath).toList();
    return FirebaseFirestore.instance
        .collection('perfiles')
        .doc(profileDocId)
        .collection('actividadesvoae')
        .add({
      'nombreActividad': nombreActividad,
      'descripcion': descripcion,
      'horasAcademicas': horasAcademicas,
      'horasSociales': horasSociales,
      'horasCulturales': horasCulturales,
      'horasDeportivas': horasDeportivas,
      'fechaActividad': fechaActividad,
      'fechaCreacion': Timestamp.now(),
      'fechaActualizacion': Timestamp.now(),
      'archivosPDF': pathsArchivosPDF,
    });
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
          setState(() {
            fechaActividad = Timestamp.fromDate(value);
            fechaActividadController.text =
                DateFormat('dd/MM/yyyy').format(value);
          });
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
        title: const Text('Nueva Actividad'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                List<Reference> referencias = await subirArchivos(archivos);

                await addActividad(
                  nombreActividadController.text,
                  fechaActividad,
                  descripcionController.text,
                  int.tryParse(horasAcademicasController.text) ?? 0,
                  int.tryParse(horasSocialesController.text) ?? 0,
                  int.tryParse(horasCulturalesController.text) ?? 0,
                  int.tryParse(horasDeportivasController.text) ?? 0,
                  referencias,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Actividad creada exitosamente!'),
                    ),
                  );
                }

                nombreActividadController.clear();
                fechaActividadController.clear();
                descripcionController.clear();
                horasAcademicasController.clear();
                horasSocialesController.clear();
                horasCulturalesController.clear();
                horasDeportivasController.clear();

                setState(() {
                  academicoIsChecked = false;
                  socialIsChecked = false;
                  culturalIsChecked = false;
                  deportivoIsChecked = false;
                  archivos.clear();
                });
              } else {
                return;
              }
            },
            label: const Text('Guardar'),
            icon: const Icon(Icons.save),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nombreActividadController,
                  autofocus: true,
                  validator: (value) =>
                      value!.isEmpty ? 'El nombre no puede estar vacio' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    label: const Text("Nombre"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fechaActividadController,
                        validator: (value) => value!.isEmpty
                            ? 'La fecha no puede estar vacia'
                            : null,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          label: const Text("Fecha de la actividad"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: _showDatePicker,
                      label: const Text('Elegir fecha'),
                      icon: const Icon(Icons.date_range),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    label: const Text("Descripción"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ámbitos:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: academicoIsChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        academicoIsChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text('Científico/Académico'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 50,
                                ),
                                child: TextFormField(
                                  enabled: academicoIsChecked,
                                  controller: horasAcademicasController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: '0'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: socialIsChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        socialIsChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text('Social'),
                                ],
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 50,
                                ),
                                child: TextFormField(
                                  enabled: socialIsChecked,
                                  controller: horasSocialesController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: '0',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: culturalIsChecked,
                                onChanged: (value) {
                                  setState(() {
                                    culturalIsChecked = value!;
                                  });
                                },
                              ),
                              const Text('Cultural'),
                              const SizedBox(
                                width: 140,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 50,
                                ),
                                child: TextFormField(
                                  enabled: culturalIsChecked,
                                  controller: horasCulturalesController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: '0',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: deportivoIsChecked,
                                onChanged: (value) {
                                  setState(() {
                                    deportivoIsChecked = value!;
                                  });
                                },
                              ),
                              const Text('Deportivo'),
                              const SizedBox(
                                width: 128,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 50,
                                ),
                                child: TextFormField(
                                  enabled: deportivoIsChecked,
                                  controller: horasDeportivasController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: '0',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50)),
                      onPressed: () async {
                        final seleccion = await seleccionarArchivos();
                        if (seleccion != null) {
                          setState(() {
                            archivos.addAll(seleccion);
                          });
                        }
                      },
                      label: const Text('Subir archivo'),
                      icon: const Icon(Icons.file_upload),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                archivos.isNotEmpty
                    ? Column(
                        children: archivos.map((archivo) {
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
                                      archivos.remove(archivo);
                                    });
                                  },
                                  child: const Text('Eliminar'),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : const Text('No se ha seleccionado ningún archivo'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
