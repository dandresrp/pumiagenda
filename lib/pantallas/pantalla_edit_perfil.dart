import 'package:flutter/material.dart';


class PantallaEditarPerfil extends StatelessWidget {
  const PantallaEditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildEditableField(label: 'Nombre'),
            const SizedBox(height: 16),
            _buildEditableField(label: 'Correo'),
            const SizedBox(height: 16),
            _buildEditableField(label: 'N. Cuenta'),
            const SizedBox(height: 16),
            _buildEditableField(label: 'Carrera'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Acción de guardar
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({required String label}) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Acción de editar
          },
        ),
      ],
    );
  }
}
