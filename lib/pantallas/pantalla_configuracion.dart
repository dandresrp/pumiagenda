import 'package:flutter/material.dart';
import 'package:pumiagenda/custom_widgets.dart';
import 'package:go_router/go_router.dart';


class PantallaConfiguracion extends StatefulWidget {
  const PantallaConfiguracion({super.key});

  @override
  State<PantallaConfiguracion> createState() => _PantallaConfiguracionState();
}

class _PantallaConfiguracionState extends State<PantallaConfiguracion> {
  var datos = {
    'nombre': 'Diego Andres Rios Pineda',
    'correo': 'driosp@unah.hn',
    'cuenta': '20212030281',
    'carrera': 'Ingenieria en Sistemas',
  };
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
                        context.push(
                          '/editarPerfil',
                          extra: datos,
                        );
                      }
          ),
          ListTile(
            title: const Text('Acerca de'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/acerca');
            },
          ),
        ],
      ),
      bottomNavigationBar: const BarraInferior(currentIndex: 2,),
    );
  }
}
