import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pumiagenda/models/actividad.dart';
import 'package:pumiagenda/models/perfil.dart';

const String perfilesCollectionRef = 'perfiles';
const String actividadesCollectionRef = 'actividadesvoae';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _perfilesRef;
  late final CollectionReference _actividadesRef;

  DatabaseService() {
    _perfilesRef = _firestore.collection(perfilesCollectionRef).withConverter<Perfil>(
      fromFirestore: (snapshots, _) => Perfil.fromJson(snapshots.data()!,),
      toFirestore: (perfil, _) => perfil.toJson()
    );
    _actividadesRef = _firestore.collection(actividadesCollectionRef).withConverter<Actividad>(
      fromFirestore: (snapshots, _) => Actividad.fromJson(snapshots.data()!,),
      toFirestore: (actividad, _) => actividad.toJson()
    );
  }

  /* PERFILES */

  Stream<QuerySnapshot> getPerfiles() {
    return _perfilesRef.snapshots();
  }

  void addPerfil(Perfil perfil) async {
    _perfilesRef.add(perfil);
  }

  void updatePerfil(String perfilId, Perfil perfil) {
    _perfilesRef.doc(perfilId).update(perfil.toJson());
  }

  void deletePerfil(String perfilId) {
    _perfilesRef.doc(perfilId).delete();
  }

  /* ACTIVIDADES */

  Stream<QuerySnapshot> getActividades() {
    return _actividadesRef.snapshots();
  }

  void addActividad(Actividad actividad) async {
    _actividadesRef.add(actividad);
  }

  void updateActividad(String actividadId, Actividad actividad) {
    _actividadesRef.doc(actividadId).update(actividad.toJson());
  }

  void deleteActividad(String actividadId) {
    _actividadesRef.doc(actividadId).delete();
  }
}