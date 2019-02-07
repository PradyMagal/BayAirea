import 'package:flutter/material.dart';
import 'tab_manager.dart';
import 'settings.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Bay Airea"), backgroundColor: Colors.tealAccent[100],),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Menu" ,style: new TextStyle(fontSize: 25),),
            ),
            
            new ListTile(
              title: new Text("Close Menu" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
              }
            ),

            new ListTile(
              title: new Text("Location 1" ,style: new TextStyle(fontSize: 15),),
            ),

            new ListTile(
              title: new Text("Settings" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.settings),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SettingsPage())),
            )

          ],
        )
      ),
      body: new Center(
        child: new Text("This is where the content goes"),
      ),
    );
  }
}
