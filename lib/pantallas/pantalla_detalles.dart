import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaDetalles extends StatefulWidget {
  final String extrasData;
  const PantallaDetalles({super.key,required this.extrasData});
  @override
  State<PantallaDetalles> createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> {
  final _formKey = GlobalKey<FormState>();
  final _nombreActividad = TextEditingController();
  final _descripcionActividad = TextEditingController();
  final _fechaActividad = TextEditingController();
  final _ambitoActividad = TextEditingController();

  @override

  void dispose() {
    _nombreActividad.dispose();
    _descripcionActividad.dispose();
    _fechaActividad.dispose();
    _ambitoActividad.dispose();
    super.dispose();
  }

  //Validar Nombre de Actividades
  String? _validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Valor obligatorio';
    }
    if (value.length > 24) {
      return 'Nombre demasiado largo';
    }
    return null;
  }

  //Validar Descripción de Actividad
  String? _validateDescripcion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Sin descripción';
    }
    if (value.length > 50) {
      return 'Descripción demasiado larga';
    }
    return null;
  }

  //Validar Fecha
  String? _validateFecha(DateTime? value) {
    if (value == null ) {
      return 'Valor obligatorio';
    }
    return null;
  }

  //Validar ambito

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go('/detalles'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    String nombre = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('PANTALLA EN MANTENIMIENTO',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.browser_not_supported,size: 100,color: Colors.amber,)              
              ],
            ),
          )

        )
      )
    );
  }
}
