import 'package:flutter/material.dart';
import 'package:turyn_viajes/pages/Lista_sitios_pages.dart';
import '../models/user.dart';
import '../repository/firebase_api.dart';
import 'login_page.dart';

class RegisterPlace extends StatefulWidget {
  const RegisterPlace({Key? key}) : super(key: key);

  @override
  State<RegisterPlace> createState() => _RegisterPlaceState();
}

class _RegisterPlaceState extends State<RegisterPlace> {
  FirebaseApi _firebaseApi = FirebaseApi();
  final _logo = TextEditingController();
  final _descCorta = TextEditingController();
  final _descLarga = TextEditingController();

  void _saveUser(Usuar _user) async {
    var result = await _firebaseApi.createUser(_user);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PerfilSitios(_user.uid)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                controller: _logo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Imagen',
                    hintText: 'Link Imagen de muestra'),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                controller: _descCorta,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción corta',
                    hintText: 'Descripción corta'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descLarga,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción Larga',
                    hintText: 'Descripción Larga'),
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  //guardamos en base de datos en user
                  var user = Usuar(
                      '',
                      '_name.text',
                      '_email.text',
                      '_password.text',
                      'genre',
                      'favoritos',
                      '_date',
                      _logo.text,
                      _descCorta.text,
                      _descLarga.text);

                  _saveUser(user);
                },
                child: Text('Almacenar sitio'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
