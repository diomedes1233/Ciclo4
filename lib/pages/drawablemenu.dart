import 'package:flutter/material.dart';

class DrawableMenu extends StatelessWidget {
  const DrawableMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      // backgroundColor: Color.fromARGB(200, 255, 255, 255),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  // margin: EdgeInsets.only(top: 50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/logo.png'),
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                Text(
                  'Turyn_viajes',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )
              ],
            ),
            // child: Text('VIAJENCOMODOS'),
            decoration: BoxDecoration(
              // color: Color.fromARGB(200, 79, 166, 238),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff00c2db)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListTile(
            iconColor: Colors.blue,
            leading: Icon(
              Icons.home,
              size: 40,
            ),
            title: Text('First item'),
            subtitle: Text("This is the 1st item"),
            trailing: Icon(Icons.more_vert),
            textColor: Colors.black,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
