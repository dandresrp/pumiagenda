import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _cuentaController = TextEditingController();
  final _carreraController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _cuentaController.dispose();
    _carreraController.dispose();
    super.dispose();
  }

  String? _validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }
    if (value.length < 3 || value.length > 40) {
      return 'El nombre debe tener mas caracteres';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go('/'); 
    }
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PumIAgenda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  child: Text(
                    'Avatar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),
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
                    labelText: 'N. Cuenta',
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
                  onPressed: _submit,
                  child: const Text('Ingresar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}