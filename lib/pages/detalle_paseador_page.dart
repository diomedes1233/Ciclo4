import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turyn_viajes/models/modelos_modelo.dart';
import 'package:turyn_viajes/models/paseadores_local.dart';
import 'package:turyn_viajes/pages/home_page.dart';
import '../repository/Boxes.dart';

class DetallePaseador extends StatefulWidget {
  final datosPaseador paseador;

  DetallePaseador(this.paseador);

  @override
  State<DetallePaseador> createState() => _DetallePaseadorState();
}

class _DetallePaseadorState extends State<DetallePaseador> {
  var favorito = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoritos();
  }

  void getFavoritos() {
    final box = Boxes.boxFavoritos();
    box.values.forEach((element) {
      if (element.id == widget.paseador.id) {
        favorito = true;
      }
    });
  }

  void agregarFavoritos() {
    var paseadorFavorito = PaseadoresLocal()
      ..id = widget.paseador.id
      ..nombre = widget.paseador.nombre
      ..contacto = widget.paseador.contacto
      ..ciudad = widget.paseador.ciudad
      ..foto = widget.paseador.foto
      ..perfil = widget.paseador.perfil;
    final box = Boxes.boxFavoritos();
    //box.add(paseadorFavorito);
    if (favorito) {
      box.delete(paseadorFavorito.id);
    } else {
      box.put(paseadorFavorito.id, paseadorFavorito);
    }
    setState(() {
      favorito = !favorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paseador.nombre),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 30),
              onPressed: () {
                agregarFavoritos();
              },
              icon: Icon(
                  favorito
                      ? FontAwesomeIcons.heartCircleCheck
                      : FontAwesomeIcons.heart,
                  size: 30,
                  color: Colors.red))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          miCardImage(
              widget.paseador.foto,
              widget.paseador.nombre +
                  "\n" +
                  widget.paseador.contacto +
                  "\n" +
                  widget.paseador.ciudad +
                  "\n\n" +
                  widget.paseador.perfil),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          )
        ]),
      ),
    );
  }
}
