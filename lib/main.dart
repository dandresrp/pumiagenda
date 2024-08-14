import 'package:flutter/material.dart';
import 'package:pumiagenda/pantallas/pantalla_ambito_cultural.dart';
import 'package:pumiagenda/pantallas/pantalla_ambito_deportivo.dart';
import 'package:pumiagenda/pantallas/pantalla_ambito_social.dart';
import 'package:pumiagenda/pantallas/pantalla_edit_perfil.dart';
import 'package:pumiagenda/pantallas/pantalla_inicio.dart';
import 'package:pumiagenda/pantallas/pantalla_horas_voae.dart';
import 'package:pumiagenda/pantallas/pantalla_ambito_cientifico_academico.dart';
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
      path: '/editarPerfil',
      builder:  (context, state) {
        final extrasData = state.extra as dynamic;
        return PantallaEditarPerfil(extrasData: extrasData);
      } 
    ),
    GoRoute(
      path: '/horasvoae',
      builder: (context, state) => const PantallaHorasVoae(),
    ),
    GoRoute(
      path: '/ambitoacademico',
      builder: (context, state) => const PantallaAmbitoCientificoAcademico(),
    ),
    GoRoute(
      path: '/ambitosocial',
      builder: (context, state) => const PantallaAmbitoSocial(),
    ),
    GoRoute(
      path: '/ambitodeportivo',
      builder: (context, state) => const PantallaAmbitoDeportivo(),
    ),
    GoRoute(
      path: '/ambitocultural',
      builder: (context, state) => const PantallaAmbitoCultural(),
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
