import 'package:flutter/material.dart';

class PantallaDetalles extends StatefulWidget {
  final String extrasData;
  const PantallaDetalles({super.key,required this.extrasData});
  @override
  State<PantallaDetalles> createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> {

  bool cultural = false;
  bool social = true;
  bool academico = false;
  bool deportivo = false;

  @override
  Widget build(BuildContext context) {
    String nombre = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Acción para volver atrás
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre Actividad',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fecha de Actividad',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Ámbito(s)', style: TextStyle(fontSize: 16)),
              CheckboxListTile(
                title: const Text('Cultural'),
                value: cultural,
                onChanged: (bool? value) {
                  setState(() {
                    cultural = value ?? false;
                  });
                },
                secondary: Container(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '0'),
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('Social'),
                value: social,
                onChanged: (bool? value) {
                  setState(() {
                    social = value ?? false;
                  });
                },
                secondary: Container(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '10'),
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('Académico'),
                value: academico,
                onChanged: (bool? value) {
                  setState(() {
                    academico = value ?? false;
                  });
                },
                secondary: Container(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '0'),
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('Deportivo'),
                value: deportivo,
                onChanged: (bool? value) {
                  setState(() {
                    deportivo = value ?? false;
                  });
                },
                secondary: Container(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '0'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Archivos Adjuntos', style: TextStyle(fontSize: 16)),
              Container(
                height: 100,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(Icons.attach_file),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}
