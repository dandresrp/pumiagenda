import 'package:cloud_firestore/cloud_firestore.dart';
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

class CardHorasInicio extends StatefulWidget {
  final String ambito;
  final String campoHoras;
  const CardHorasInicio({
    required this.ambito,
    required this.campoHoras,
    super.key,
  });

  @override
  State<CardHorasInicio> createState() => _CardHorasInicioState();
}

class _CardHorasInicioState extends State<CardHorasInicio> {
  Future<int> getHorasTotales(String campoHoras) async {
    final firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection('actividadesvoae').get();

    int horasTotales = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      horasTotales += (data[campoHoras] as int?) ?? 0;
    }

    return horasTotales;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHorasTotales(widget.campoHoras),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Center(
                child: LinearProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Horas Ámbito ${widget.ambito}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${snapshot.data}/15',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Center(
                child: Text('No hay data...'),
              ),
            ),
          );
        }
      },
    );

    /* return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Horas Ámbito ${widget.ambito}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder(
              future: obtenerHorasTotales(widget.campoHoras),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}/15',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  );
                } else {
                  return const Text(
                    '0/15',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ); */
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
