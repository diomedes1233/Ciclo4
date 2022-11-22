import 'package:cloud_firestore/cloud_firestore.dart';

class datosSitios {
  String id = "";
  String name = "";
  String phone = "";
  String images = "";
  String ciudad = "";
  String departamet = "";
  late GeoPoint location;

  datosSitios(
    this.id,
    this.name,
    this.phone,
    this.images,
    this.ciudad,
    this.departamet,
    this.location,
  );
}
