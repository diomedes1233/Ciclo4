import 'package:flutter/material.dart';
import 'package:turyn_viajes/models/user.dart';
import 'package:turyn_viajes/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../repository/firebase_api.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  User userLoad = User.Empty();
  final FirebaseApi _firebaseApi = FirebaseApi();

  @override
  void initState() {
    // _getUser();
    super.initState();
  }

  _getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(pref.getString("user")!);
    userLoad = User.fromJson(userMap);
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
      _showMsg("Debe digitar el correo y la contraceña");
    } else {
      var result = await _firebaseApi.logInUser(_email.text, _password.text);
      String msg = "";
      if (result == "invalid-email") {
        msg = "El correo electrónico está mal escrito";
      } else if (result == "wrong-password") {
        msg = "Correo o contraceña incorecta";
      } else if (result == "network-request-failed") {
        msg = "Revise su conexión a internet";
      } else {
        msg = "Bienbenid@";
      }
      _showMsg("Correo o contraceña incorrecta");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo Electronico'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Contraceña'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    _validateUser();
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: const Text('Registrese'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
