import 'package:flutter/material.dart';

import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tures y Viajes"),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.push(context,
                //MaterialPageRoute(builder: (context) => PaseadoresPage()));
              },
              icon: const Icon(Icons.accessibility_rounded,
                  size: 30, color: Colors.white))
        ],
      ),
      drawer: MenuPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Tures y viajes',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Cascads de Payandé',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: AssetImage('assets/images/cascada_de_payande.jpg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Las cascadas de Payandé son un paraíso natural de 7 cascadas ubicadas a 30 minutos de Ibagué en el corregimiento de Payandé al oriente del departamento del Tolima. Los pozos naturales de aguas cristalinas que se forman en este sitio lo han convertido en un atractivo natural a los alrededores de la capital del Tolima.',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Termales',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: AssetImage('assets/images/termales-la-cabana.jpg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'En estos termales encontrarás aguas cristalinas de tonos azulados y toques de verde, también conocerás la Quebrada de los 7 colores y caminarás hasta la Laguna Corazón ubicada a los 4.100 m.s.n.m, la cual era visitada por algunas culturas indígenas de la zona.',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Entre a la pagina')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class miCardImage extends StatelessWidget {
  final String url;
  final String texto;

  miCardImage(this.url, this.texto);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.all(20),
      elevation: 20,
      color: Colors.lightGreenAccent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Column(
          children: [
            Image.network(
              url,
              width: MediaQuery.of(context).size.width,
              height: 250,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              color: Colors.lightGreenAccent,
              child: Text(texto,
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
