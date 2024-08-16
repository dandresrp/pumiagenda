import 'package:cloud_firestore/cloud_firestore.dart';

class Actividad {
  String nombreActividad;
  String descripcion;
  int horasAcademicas;
  int horasCulturales;
  int horasSociales;
  int horasDeportivas;
  Timestamp fechaActividad;
  Timestamp fechaCreacion;
  Timestamp fechaActualizacion;

  Actividad({
    required this.nombreActividad,
    required this.descripcion,
    required this.horasAcademicas,
    required this.horasCulturales,
    required this.horasSociales,
    required this.horasDeportivas,
    required this.fechaActividad,
    required this.fechaCreacion,
    required this.fechaActualizacion,
  });

  Actividad.fromJson(Map<String, Object?> json) : this(
    nombreActividad: json['nombreActividad']! as String,
    descripcion: json['descripcion']! as String,
    horasAcademicas: json['horasAcademicas']! as int,
    horasCulturales: json['horasCulturales']! as int,
    horasSociales: json['horasSociales']! as int,
    horasDeportivas: json['horasDeportivas']! as int,
    fechaActividad: json['fechaActividad']! as Timestamp,
    fechaCreacion: json['fechaCreacion']! as Timestamp,
    fechaActualizacion: json['fechaActualizacion']! as Timestamp,
  );

  Actividad copyWith({
    String? nombreActividad,
    String? descripcion,
    int? horasAcademicas,
    int? horasCulturales,
    int? horasSociales,
    int? horasDeportivas,
    Timestamp? fechaActividad,
    Timestamp? fechaCreacion,
    Timestamp? fechaActualizacion,
  }) => Actividad(
      nombreActividad: nombreActividad ?? this.nombreActividad,
      descripcion: descripcion ?? this.descripcion,
      horasAcademicas: horasAcademicas ?? this.horasAcademicas,
      horasCulturales: horasCulturales ?? this.horasCulturales,
      horasSociales: horasSociales ?? this.horasSociales,
      horasDeportivas: horasDeportivas ?? this.horasDeportivas,
      fechaActividad: fechaActividad ?? this.fechaActividad,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
    );

  Map<String, Object?> toJson() {
    return {
      'nombreActividad': nombreActividad,
      'descripcion': descripcion,
      'horasAcademicas': horasAcademicas,
      'horasCulturales': horasCulturales,
      'horasSociales': horasSociales,
      'horasDeportivas': horasDeportivas,
      'fechaActividad': fechaActividad,
      'fechaCreacion': fechaCreacion,
      'fechaActualizacion': fechaActualizacion,
    };
  }
}