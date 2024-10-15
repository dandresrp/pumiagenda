import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Actividad {
  final String? nombre;
  final String? descripcion;
  final int? horasAcademicas;
  final int? horasSociales;
  final int? horasCulturales;
  final int? horasDeportivas;
  final Timestamp? fechaActividad;
  final Timestamp? fechaCreacion;
  final Timestamp? fechaActualizacion;
  final List<Reference>? referenciasArchivosPDF;

  Actividad({
    required this.nombre,
    required this.descripcion,
    required this.horasAcademicas,
    required this.horasSociales,
    required this.horasCulturales,
    required this.horasDeportivas,
    required this.fechaActividad,
    this.referenciasArchivosPDF,
    this.fechaCreacion,
    this.fechaActualizacion,
  });

  factory Actividad.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Actividad(
      nombre: data?['nombre'],
      descripcion: data?['descripcion'],
      horasAcademicas: data?['horasAcademicas'],
      horasSociales: data?['horasSociales'],
      horasCulturales: data?['horasCulturales'],
      horasDeportivas: data?['horasDeportivas'],
      fechaActividad: data?['fechaActividad'],
      fechaCreacion: data?['fechaCreacion'],
      fechaActualizacion: data?['fechaActualizacion'],
      referenciasArchivosPDF: data?['referenciasArchivosPDF'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (descripcion != null) "descripcion": descripcion,
      if (horasAcademicas != null) "horasAcademicas": horasAcademicas,
      if (horasSociales != null) "horasSociales": horasSociales,
      if (horasCulturales != null) "horasCulturales": horasCulturales,
      if (horasDeportivas != null) "horasDeportivas": horasDeportivas,
      if (fechaActividad != null) "fechaActividad": fechaActividad,
      if (fechaCreacion != null) "fechaCreacion": fechaCreacion,
      if (fechaActualizacion != null) "fechaActualizacion": fechaActualizacion,
      if (referenciasArchivosPDF != null)
        "referenciasArchivosPDF": referenciasArchivosPDF,
    };
  }

  Future<void> add(String docUsuario) async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(docUsuario)
        .collection('actividades')
        .withConverter(
          fromFirestore: Actividad.fromFirestore,
          toFirestore: (Actividad actividad, options) =>
              actividad.toFirestore(),
        )
        .doc()
        .set(copyWith(
          fechaCreacion: Timestamp.now(),
          fechaActualizacion: Timestamp.now(),
        ));
  }

  Future<void> update(String docUsuario, String docActividad) async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(docUsuario)
        .collection('actividades')
        .withConverter(
          fromFirestore: Actividad.fromFirestore,
          toFirestore: (Actividad actividad, options) =>
              actividad.toFirestore(),
        )
        .doc(docActividad)
        .update(copyWith(
          fechaActualizacion: Timestamp.now(),
        ).toFirestore());
  }

  Actividad copyWith({
    String? nombre,
    String? descripcion,
    int? horasAcademicas,
    int? horasSociales,
    int? horasCulturales,
    int? horasDeportivas,
    Timestamp? fechaActividad,
    Timestamp? fechaCreacion,
    Timestamp? fechaActualizacion,
    List<Reference>? referenciasArchivosPDF,
  }) {
    return Actividad(
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      horasAcademicas: horasAcademicas ?? this.horasAcademicas,
      horasSociales: horasSociales ?? this.horasSociales,
      horasCulturales: horasCulturales ?? this.horasCulturales,
      horasDeportivas: horasDeportivas ?? this.horasDeportivas,
      fechaActividad: fechaActividad ?? this.fechaActividad,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      referenciasArchivosPDF:
          referenciasArchivosPDF ?? this.referenciasArchivosPDF,
    );
  }
}
