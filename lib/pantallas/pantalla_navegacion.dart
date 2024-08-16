import 'package:flutter/material.dart';
import 'package:pumiagenda/pantallas/pantalla_inicio.dart';
import 'package:pumiagenda/pantallas/pantalla_horas_voae.dart';
import 'package:pumiagenda/custom_widgets.dart';
import 'package:pumiagenda/pantallas/pantalla_configuracion.dart';

class PantallaNavegacion extends StatefulWidget {
  const PantallaNavegacion({super.key});

  @override
  State<PantallaNavegacion> createState() => _HomePageState();
}

class _HomePageState extends State<PantallaNavegacion> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          PantallaInicio(),
          PantallaHorasVoae(),
          PantallaConfiguracion()
        ],
      ),
      bottomNavigationBar: BarraInferior(
        currentIndex: _currentIndex,
        pageController: _pageController,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
