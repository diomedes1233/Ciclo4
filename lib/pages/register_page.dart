import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:turyn_viajes/models/user.dart';
import 'package:turyn_viajes/pages/login_page.dart';
import 'package:turyn_viajes/repository/firebase_api.dart';

import '../main.dart';

//clase
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { masculino, femenino }

//variables
class _RegisterPageState extends State<RegisterPage> {
  FirebaseApi _firebaseApi = FirebaseApi();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  final _logo = TextEditingController();
  final _descCorta = TextEditingController();
  final _descLarga = TextEditingController();
  String _data = "Información: ";
  Genre? _genre = Genre.masculino;
  bool _aventura = false;
  bool _fantacia = false;
  bool _terror = false;
  String buttonMsg = "fecha de nacimiento";
  final _llaveValidar = GlobalKey<FormState>(); // lave validacion formularios
  String msg = "", msg2 = "", msg3 = "", msg4 = "", msgP = "";
  bool visilogo = false, visidesC = false, visidesL = false;

  String _date = "";

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  //metodo o funcion 1
  void _showSelectDate() async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale("es", "CO"),
        initialDate: DateTime(2022, 6),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2022, 12),
        helpText: "Fecha de nacimiento");
    if (newDate != null) {
      setState(() {
        _date = _dateConverter(newDate);
        buttonMsg = "Fecha de nacimiento: ${_date.toString()}";
      });
    }
  }

  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'Aceptar', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _saveUser(Usuar user) async {
    var result = await _firebaseApi.createUser(user);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _registerUser(Usuar user) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("user", jsonEncode(user));
    var result = await _firebaseApi.registerUser(user.email, user.password);
    msg = msg2 = msg3 = msg4 = msgP = "";
    print('******Registrar dice: ********$result***********');
    if (result == "invalid-email") {
      msg2 = "El correo electrónico está mal escrito";
      msgP = 'Correo no valido, debe tener @, .com y sin espacios';
    } else if (result == "wrong-password") {
      msg3 = msgP = "contraseña incorrecta";
    } else if (result == "weak-password") {
      msg3 = msgP = "Debe tener al menos 6 caracteres ";
    } else if (result == "network-request-failed") {
      msgP = "Revise su conexión a internet";
    } else if (result == "user-not-found") {
      msg2 = msgP = "Usuario No encontrado";
    } else if (!_name.text.contains(' ')) {
      msg = msgP = "Ingrese nombre completo";
    } else if (!_email.text.contains('@') &&
        !_email.text.contains('.com') &&
        _email.text.contains(' ')) {
      msg2 = "El correo electrónico está mal escrito";
      msgP = 'Correo no valido, debe tener @, .com y sin espacios';
    } else if (_password.text != _repPassword.text ||
        _repPassword.text.isEmpty) {
      msg3 = msg4 = msgP = "contraseñas no coinciden";
    } else if (result == "unknown") {
      // msg = "Error desconocido";
    } else if (result == 'email-already-in-use') {
      msg2 = msgP = "Correo ya está en uso";
    } else {
      msgP = "Usuario registrado con éxito";
      user.uid = result;
      _saveUser(user);
    }
    print('************logro pasara caa');
    _showMsg(msgP);
    _llaveValidar.currentState!.validate();
  }

  //metodo o funcion 2
  void _onRegisterButtooClicked() {
    setState(() {
      if (_date.isNotEmpty ||
          _repPassword.text.isNotEmpty ||
          _email.text.isNotEmpty ||
          _name.text.isNotEmpty) {
        String genre = "Masculino";
        String favoritos = "";

        if (_genre == Genre.femenino) {
          genre = "Femenino";
        }

        if (_aventura) favoritos = "$favoritos Aventura";
        if (_fantacia) favoritos = "$favoritos Fantasia";
        if (_terror) favoritos = "$favoritos Terror";

        //guardamos en base de datos en user
        var user = Usuar('', _name.text, _email.text, _password.text, genre,
            favoritos, _date, _logo.text, _descCorta.text, _descLarga.text);
        _registerUser(user);
        //me traslada a la pagina de login

        //si las claves no son iguales envia este mensaje
      } else {
        _showMsg('Revise todos los campos');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.art_track),
            tooltip: 'Ir al Home',
            onPressed: () {
              // para redirigir
              _toggleFieldView();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
      // drawer: DrawableMenu(),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Form(
            key: _llaveValidar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Image(image: AssetImage('assets/images/logo.png')),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg != '') {
                      return msg;
                    }
                    return null;
                  }, // fin validator
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      hintText: 'Nombre completo'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg2 != '') {
                      return msg2;
                    }
                    return null;
                  }, // fin validator
                  controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo Electrónico',
                      hintText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg3 != '') {
                      return msg3;
                    }
                    return null;
                  }, // fin validator
                  controller: _password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: 'Ingrese Contraseña'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg4 != '') {
                      return msg4;
                    }
                    return null;
                  }, // fin validator
                  controller: _repPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: 'Repita Contraseña'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('Masc'),
                        leading: Radio<Genre>(
                          value: Genre.masculino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Fem'),
                        leading: Radio<Genre>(
                          value: Genre.femenino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Géneros Favoritos',
                  style: TextStyle(fontSize: 20),
                ),
                CheckboxListTile(
                  title: Text('Aventura'),
                  value: _aventura,
                  selected: _aventura,
                  onChanged: (bool? value) {
                    setState(() {
                      _aventura = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Fantasia'),
                  value: _fantacia,
                  selected: _fantacia,
                  onChanged: (bool? value) {
                    setState(() {
                      _fantacia = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Terror'),
                  value: _terror,
                  selected: _terror,
                  onChanged: (bool? value) {
                    setState(() {
                      _terror = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _showSelectDate();
                  },
                  child: Text(buttonMsg),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 26),
                  ),
                  onPressed: () {
                    // _llaveValidar.currentState!.validate();
                    _onRegisterButtooClicked();
                  },
                  child: const Text("Registrar",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _toggleFieldView() {
    setState(() {
      visilogo = visidesC = visidesL = true;
    });
  } // fin _toggleFieldView();
}
