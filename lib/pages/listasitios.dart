import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turyn_viajes/main.dart';
import 'drawablemenu.dart';

class ListaSitios extends StatefulWidget {
  final dk;
  const ListaSitios(this.dk, {Key? key}) : super(key: key);

  @override
  State<ListaSitios> createState() => _ListaSitiosState();
}

class _ListaSitiosState extends State<ListaSitios> {
  @override
  Widget build(BuildContext context) {
    var k = widget.dk; // leo variable de otro widget
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sitios de Interes'),
          elevation: 10,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              tooltip: 'Ir al Home',
              onPressed: () {
                // para redirigir
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        // drawer: DrawableMenu(),
        body: Padding(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          padding: EdgeInsets.all(5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: k)
                .snapshots(), // llerr datos FB
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error enla consulta');
              } // fin if
              else if (!snapshot.hasData) {
                return Text('No existen datos');
              } // fin if
              else {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot usuarioFB =
                        snapshot.data!.docs[index];
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 5,
                          color: Colors.green,
                          child: ListTile(
                            title: Text(
                              '${usuarioFB['name']} :   ',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                // color: Colors.black
                              ),
                            ),
                            subtitle: Text('${usuarioFB['descLarga']}  '),
                            leading: Image.network(usuarioFB['logo']),
                          ),
                        ),
                      ],
                    );
                  }, // fin item builder
                );
              } // fin else
            }, // fin Stream
          ),
          // ],
        ),
      ),
    );
  }
}
