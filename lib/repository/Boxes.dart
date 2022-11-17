import 'package:hive/hive.dart';
import 'package:turyn_viajes/models/paseadores_local.dart';

class Boxes {
  static Box<PaseadoresLocal> boxFavoritos() =>
      Hive.box<PaseadoresLocal>('favoritos');
}
