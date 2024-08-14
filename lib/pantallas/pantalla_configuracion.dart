import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';
import 'package:go_router/go_router.dart';


class PantallaConfiguracion extends StatelessWidget {
  const PantallaConfiguracion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Perfil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/editarPerfil');
            },
          ),
          ListTile(
            title: const Text('Acerca de'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.go('/acerca');
            },
          ),
        ],
      ),
      bottomNavigationBar: const BarraInferior(currentIndex: 2,),
    );
  }
}
