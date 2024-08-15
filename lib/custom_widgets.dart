import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarraInferior extends StatefulWidget {
  final int currentIndex;
  const BarraInferior({required this.currentIndex, super.key});

  @override
  State<BarraInferior> createState() => _BarraInferiorState();
}

class _BarraInferiorState extends State<BarraInferior> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.currentIndex;
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        context.push('/');
        break;
      case 1:
        context.push('/horasvoae');
        break;
      // case 2:
      //   GoRouter.of(context).go('/configuracion');
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          _navigateToPage(index);
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        NavigationDestination(
          icon: Icon(Icons.watch_later_outlined),
          label: 'Horas VOAE',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          label: 'Configuración',
        ),
      ],
    );
  }
}

class CardHorasInicio extends StatelessWidget {
  final String ambito;
  const CardHorasInicio({required this.ambito, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Horas Ambito $ambito',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '0/10',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardHorasVoae extends StatelessWidget {
  final String ambito;
  final Icon icon;
  const CardHorasVoae({required this.ambito, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ambito $ambito',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              radius: 30.0,
              child: icon,
            )
          ],
        ),
      ),
      onPressed: () => context.push('/ambito', extra: ambito)
    );
  }
}

//card Roberto
class ActividadCard extends StatelessWidget {
  final String nombre;
  final String fecha;

  const ActividadCard({super.key, required this.nombre, required this.fecha});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, 
      child: Card(
        elevation: 2.0,
        child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0), 
                      minimumSize: const Size(0, 0), 
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    ),
                    onPressed: () => context.push('/ambito', extra: nombre),
                    child: const Text(
                      'Detalles',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                fecha,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
