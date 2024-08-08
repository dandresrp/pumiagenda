import 'package:flutter/material.dart';
import 'package:pumiagenda/pantallas/pantalla_edit_perfil.dart';
import 'package:pumiagenda/pantallas/pantalla_inicio.dart';
import 'package:pumiagenda/pantallas/pantalla_horas_voae.dart';
import 'package:go_router/go_router.dart';
import 'package:pumiagenda/pantallas/pantalla_registro.dart';

void main() {
  runApp(const MyApp());
}


GoRouter router = GoRouter(
  
  routes: [
    
    GoRoute(
      path: '/',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path: '/Registro',
      builder: (context, state) => const PantallaRegistro(), 
      ),
    GoRoute(
      path: '/editPerfil',
      builder: (context, state) => const PantallaEditarPerfil(),
    ),
    GoRoute(
      path: '/horasvoae',
      builder: (context, state) => const PantallaHorasVoae(),
    ),
    
    // GoRoute(
    //   path: '/configuracion',
    //   builder: (context, state) => const PantallaConfiguracion(),
    // )
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
