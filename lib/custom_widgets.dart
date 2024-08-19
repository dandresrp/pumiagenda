import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarraInferior extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;
  const BarraInferior({
    required this.currentIndex,
    required this.pageController,
    super.key,
  });

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

  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
    widget.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        _onDestinationSelected(index);
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
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: () => context.push('/ambito', extra: ambito),
      child: Card(
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
      ),
    );
  }
}
