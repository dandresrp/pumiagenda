import 'package:flutter/material.dart';

class PantallaDetalles extends StatefulWidget {
  final String extrasData;
  const PantallaDetalles({super.key,required this.extrasData});
  @override
  State<PantallaDetalles> createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> {

  @override
  Widget build(BuildContext context) {
    String nombre = widget.extrasData;
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('')
        )
      )
    );
  }
}
