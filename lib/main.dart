import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pumiagenda/pantallas/pantalla_crear_actividad.dart';
import 'package:pumiagenda/pantallas/pantalla_acercade.dart';
import 'firebase_options.dart';
import 'package:pumiagenda/pantallas/pantalla_navegacion.dart';
import 'package:pumiagenda/pantallas/pantalla_detalles.dart';
import 'package:pumiagenda/pantallas/pantalla_inicio.dart';
import 'package:pumiagenda/pantallas/pantalla_horas_voae.dart';
import 'package:pumiagenda/pantallas/pantalla_editar_perfil.dart';
import 'package:pumiagenda/pantallas/pantalla_ambito.dart';
import 'package:pumiagenda/pantallas/pantalla_registro.dart';
import 'package:pumiagenda/pantallas/pantalla_configuracion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const PantallaNavegacion(),
  ),
  GoRoute(
    path: '/inicio',
    builder: (context, state) => const PantallaInicio(),
  ),
  GoRoute(
    path: '/registro',
    builder: (context, state) => const PantallaRegistro(),
  ),
  GoRoute(
      path: '/editarPerfil',
      builder: (context, state) {
        final extrasData = state.extra as dynamic;
        return PantallaEditarPerfil(extrasData: extrasData);
      }),
  GoRoute(
    path: '/horasvoae',
    builder: (context, state) => const PantallaHorasVoae(),
  ),
  GoRoute(
    path: '/ambito',
    builder: (context, state) {
      final extrasData = state.extra as String;
      return PantallaAmbito(extrasData: extrasData);
    },
  ),
  GoRoute(
    path: '/detalles',
    builder: (context, state) {
      final extrasData = state.extra as String;
      return PantallaDetalles(extrasData: extrasData);
    },
  ),
  GoRoute(
    path: '/configuracion',
    builder: (context, state) => const PantallaConfiguracion(),
  ),
  GoRoute(
    path: '/acerca',
    builder: (context, state) => const PantallaAcercade(),
  )
]);

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
