import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sitios_Registrar {
  Future<String> crearSitios(sitios) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      QuerySnapshot nombreSitios = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(uid)
          .collection("sitios")
          .where("nombre", isEqualTo: sitios.nombre)
          .get();
      if (nombreSitios.docs.isEmpty) {
        final documentMasc = await FirebaseFirestore.instance
            .collection("Usuarios")
            .doc(uid)
            .collection("sitios")
            .doc();
        sitios.id = documentMasc.id;
        final resultado = await FirebaseFirestore.instance
            .collection("Usuarios")
            .doc(uid)
            .collection("sitios")
            .doc(sitios.id)
            .set(sitios.convertir());
        return sitios.id;
      } else {
        return "El sito ya existe";
      }
    } on FirebaseException catch (e) {
      print(e.code);
      return e.code;
    }
  }
}
