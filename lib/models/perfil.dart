import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  String nombre;
  String correo;
  String carrera;
  int cuenta;
  Timestamp fechaCreacion;

  Perfil({
    required this.nombre,
    required this.correo,
    required this.carrera,
    required this.cuenta,
    required this.fechaCreacion,
  });

  Perfil.fromJson(Map<String, Object?> json) : this(
    nombre: json['nombre']! as String,
    correo: json['correo']! as String,
    carrera: json['carrera']! as String,
    cuenta: json['cuenta']! as int,
    fechaCreacion: json['fechaCreacion']! as Timestamp,
  );

  Perfil copyWith({
    String? nombre,
    String? correo,
    String? carrera,
    int? cuenta,
    Timestamp? fechaCreacion
  }) => Perfil(
      nombre: nombre ?? this.nombre,
      correo: correo ?? this.correo,
      carrera: carrera ?? this.carrera,
      cuenta: cuenta ?? this.cuenta,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );

  Map<String, Object?> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'carrera': carrera,
      'cuenta': cuenta,
      'fechaCreacion': fechaCreacion,
    };
  }
}