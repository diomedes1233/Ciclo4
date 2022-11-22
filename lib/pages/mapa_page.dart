import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turyn_viajes/models/modelos_modelo.dart';
import 'package:turyn_viajes/pages/menu_page.dart';

class MapaPage extends StatefulWidget {
  final datosSitios sitios;

  MapaPage(this.sitios);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    final posicion = CameraPosition(
        target: LatLng(widget.sitios.location.latitude,
            widget.sitios.location.longitude),
        zoom: 15);

    final Set<Marker> marcador = Set();

    setState(() {

      marcador.add(Marker(
          markerId: MarkerId(widget.sitios.id),
          position: LatLng(widget.sitios.location.latitude,
              widget.sitios.location.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
              title: widget.sitios.name,
              snippet: widget.sitios.phone)));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sitios.name),
      ),
      //drawer: MenuPage(),
      body: GoogleMap(
        initialCameraPosition: posicion,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: false,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        markers: marcador,
      ),
      bottomNavigationBar: const menuInferior(),
    );
  }
}
