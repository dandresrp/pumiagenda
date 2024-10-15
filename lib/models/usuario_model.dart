import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? nombre;
  final String? correo;
  final int? cuenta;
  final String? carrera;
  final String? avatar;

  Usuario({
    this.nombre,
    this.correo,
    this.cuenta,
    this.carrera,
    this.avatar,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      nombre: data?['nombre'],
      cuenta: data?['cuenta'],
      correo: data?['correo'],
      carrera: data?['carrera'],
      avatar: data?['avatar'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (cuenta != null) "cuenta": cuenta,
      if (correo != null) "correo": correo,
      if (carrera != null) "carrera": carrera,
      if (avatar != null) "avatar": avatar,
    };
  }

  Future<void> add() async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario usuario, options) => usuario.toFirestore(),
        )
        .doc(cuenta.toString())
        .set(this);
  }
}
