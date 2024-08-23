import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pumiagenda/pantallas/pantalla_acercade.dart';
import 'package:pumiagenda/pantallas/pantalla_editar_actividad.dart';
import 'firebase_options.dart';
import 'pantallas/pantalla_crear_actividad.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isRegistered = false;
  GoRouter? router;

  @override
  void initState() {
    super.initState();
    _setupRouter();
    _checkIfRegistered().then((_) {
      _setupRouter();
    });
  }

  Future<void> _checkIfRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRegistered = prefs.getBool('isRegistered') ?? false;

    setState(() {
      _isRegistered = isRegistered;
    });
  }

  void _setupRouter() {
    router = GoRouter(
      initialLocation: _isRegistered ? '/' : '/registro',
      routes: [
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
          builder: (context, state) => const PantallaEditarPerfil(),
        ),
        GoRoute(
          path: '/horasVoae',
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
          path: '/nuevaActividad',
          builder: (context, state) => const NuevaActividad(),
        ),
        GoRoute(
          path: '/editarActividad',
          builder: (context, state) {
            final extrasData = state.extra as dynamic;
            return PantallaEditarActividad(extrasData: extrasData);
          },
        ),
        GoRoute(
          path: '/acerca',
          builder: (context, state) => const PantallaAcercade(),
        )
      ],
    );
  }

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
