import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turyn_viajes/main.dart';
import 'package:turyn_viajes/pages/perfilsitios.dart';
import 'package:turyn_viajes/pages/register_page.dart';

import '../models/user.dart';
import '../repository/firebase_api.dart';
import 'drawablemenu.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _llaveValidar = GlobalKey<FormState>(); // lave validacion formularios
  String msg = "", msg2 = "";
  bool esHidenPassword = true; // visibilidad password

  Usuar userLoad = Usuar.Empty();
  final FirebaseApi _firebaseApi = FirebaseApi();

  @override
  void initState() {
    // _getUser();
    super.initState();
  }

  _getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(pref.getString("user")!);
    userLoad = Usuar.fromJson(userMap);
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

  void _validateUser() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg("Debe digitar el correo y la contraseña");
    } else {
      var result = await _firebaseApi.logInUser(_email.text, _password.text);
      msg = msg2 = "";
      print('******Login dice: ******** $result ***********');
      if (result == "invalid-email") {
        msg = "El correo electrónico está mal escrito";
      } else if (result == "wrong-password") {
        msg2 = "contraseña incorrecta";
      } else if (result == "weak-password") {
        msg2 = "Debe tener al menos 6 caracteres ";
      } else if (result == "network-request-failed") {
        msg = "Revise su conexión a internet";
      } else if (result == "user-not-found") {
        msg = "Usuario No encontrado";
      } else if (result == "unknown") {
        msg = "Error desconocido";
      } else if (result == 'email-already-in-use') {
        msg = "Correo ya esta en uso";
      } else if (result != null) {
        msg = "Usuario registrado con éxito";
        var key =
            (FirebaseAuth.instance.currentUser?.uid); // consultar id usuario
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(key, _email.text)));
      }
      _showMsg(msg);
      _llaveValidar.currentState!.validate();
    }
  }

  _togglePasswordView() {
    setState(() {
      esHidenPassword = !esHidenPassword; // cambiar visibilidad
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawableMenu(),
      body: ListView(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.all(50),
        children: [
          Form(
            key: _llaveValidar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg != '') {
                      return msg;
                    }
                    return null;
                  }, // fin validator
                  controller: _email,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.account_circle,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Correo Electrónico',
                      hintText: "Ingrese su correo"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  validator: (valor) {
                    if (msg2 != '') {
                      return msg2;
                    }
                    return null;
                  }, // fin validator
                  controller: _password,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.password,
                      ),
                      suffixIcon: InkWell(
                          // onTap: _togglePasswordView,
                          child: Icon(
                        Icons.visibility,
                        // size: 30,
                      )),
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: "Ingrese su contraseña"),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: esHidenPassword,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      _validateUser();
                      // _llaveValidar.currentState!.validate();
                    },
                    child: const Text('Iniciar sesión')),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: const Text('Regístrese'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
