import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaEditarPerfil extends StatefulWidget {
  final dynamic extrasData;

  const PantallaEditarPerfil({super.key, required this.extrasData});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaEditarPerfilState createState() => _PantallaEditarPerfilState();
}

class _PantallaEditarPerfilState extends State<PantallaEditarPerfil> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _cuentaController = TextEditingController();
  final _carreraController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    if (value.length < 3) {
      return 'El nombre debe tener al menos 3 letras';
    }
    return null;
  }

  String? _validateCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo';
    }
    if (!value.endsWith('@unah.hn')) {
      return 'Utilice su correo institucional de estudiante';
    }
    return null;
  }

  String? _validateCuenta(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su número de cuenta';
    }
    if (value.length != 11) {
      return 'El número de cuenta debe tener 11 dígitos';
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
    if (value.length <= 3) {
      return 'La carrera debe tener más de 3 caracteres';
    }
    return null;
  }

  // TODO: Guardar nuevos datos
  void _guardarDatos() {
    if (_formKey.currentState!.validate()) {
      context.pushReplacement(
        '/',
         extra: {
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'cuenta': _cuentaController.text,
          'carrera': _carreraController.text,
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _nombreController.text = widget.extrasData['nombre'];
    _correoController.text = widget.extrasData['correo'];
    _carreraController.text = widget.extrasData['carrera'];
    _cuentaController.text = widget.extrasData['cuenta'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Text(
                  'Avatar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Nombre',
                
                controller: _nombreController,
                validator: _validateNombre,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Correo',
                controller: _correoController,
                validator: _validateCorreo,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Cuenta',
                controller: _cuentaController,
                validator: _validateCuenta,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Carrera',
                controller: _carreraController,
                validator: _validateCarrera,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _guardarDatos,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator: validator,
          ),
        )
      ],
    );
  }
}
