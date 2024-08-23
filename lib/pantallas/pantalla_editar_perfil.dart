import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaEditarPerfil extends StatefulWidget {
  const PantallaEditarPerfil({super.key});

  @override
  _PantallaEditarPerfilState createState() => _PantallaEditarPerfilState();
}

class _PantallaEditarPerfilState extends State<PantallaEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _cuentaController = TextEditingController();
  final _carreraController = TextEditingController();
  String avatar = 'person';
  String? profileDocId;

  @override
  void initState() {
    super.initState();
    _getProfileDocId().then((_) {
      if (profileDocId != null) {
        _getPerfilData(profileDocId!);
      }
    });
  }

  Future<void> _getProfileDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileDocId = prefs.getString('profileDocId');
    });
  }

  Future<void> _getPerfilData(String perfilId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('perfiles')
        .doc(perfilId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      setState(() {
        _nombreController.text = data['nombre'];
        _correoController.text = data['correo'];
        _cuentaController.text = data['cuenta'].toString();
        _carreraController.text = data['carrera'];
        avatar = data['avatar'];
      });
    }
  }

  String? _validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }
    if (value.length < 3 || value.length > 40) {
      return 'El nombre debe tener más caracteres';
    }
    return null;
  }

  String? _validateCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo';
    }
    if (!value.endsWith('@unah.hn')) {
      return 'Correo no válido';
    }
    return null;
  }

  String? _validateCuenta(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su número de cuenta';
    }
    if (value.length != 11) {
      return 'Número de cuenta no válido';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'El número de cuenta debe contener solo dígitos';
    }
    return null;
  }

  String? _validateCarrera(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su carrera';
    }
    if (value.length < 5 || value.length > 50) {
      return 'Ingrese un nombre de carrera';
    }
    return null;
  }

  Future<void> updatePerfil(
    String nombre,
    String correo,
    int cuenta,
    String carrera,
    String avatar,
  ) async {
    await FirebaseFirestore.instance
        .collection('perfiles')
        .doc(profileDocId)
        .update(
      {
        'nombre': nombre,
        'correo': correo,
        'cuenta': cuenta,
        'carrera': carrera,
        'avatar': avatar,
      },
    );
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
        title: const Center(child: Text('PumiAgenda')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(
                            child: Text('Seleccione un avatar'),
                          ),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      avatar = 'person';
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.person, size: 50),
                                      Text('Usuario'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      avatar = 'business';
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.school, size: 50),
                                      Text('Licenciatura'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      avatar = 'healing_outlined';
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.healing_outlined, size: 50),
                                      Text('Salud'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      avatar = 'engineering';
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.engineering, size: 50),
                                      Text('Ingeniería'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: _getIconByName(avatar),
                  iconSize: 100,
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNombre,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo Institucional',
                  border: OutlineInputBorder(),
                ),
                validator: _validateCorreo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cuentaController,
                decoration: const InputDecoration(
                  labelText: 'Cuenta',
                  border: OutlineInputBorder(),
                ),
                validator: _validateCuenta,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _carreraController,
                decoration: const InputDecoration(
                  labelText: 'Carrera',
                  border: OutlineInputBorder(),
                ),
                validator: _validateCarrera,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await updatePerfil(
                      _nombreController.text,
                      _correoController.text,
                      int.parse(_cuentaController.text),
                      _carreraController.text,
                      avatar,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
