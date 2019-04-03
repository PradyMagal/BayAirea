import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings", style: TextStyle(color: Colors.black),), backgroundColor: Colors.grey[300], ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Menu" ,style: new TextStyle(fontSize: 25),), 
            ),

            new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text("Close Menu" ,style: new TextStyle(fontSize: 15),),
              onTap: () {
                Navigator.pop(context);
              }
            ),

            
            new ListTile(
              title: new Text("Home" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.home),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HomePage())),
            ),
            
            
          ],
        )
      ),
      body: new ListView(
        children: <Widget>[
        new ListTile(
              trailing: Icon(Icons.info),
              title: Text("About Us"),
              // onTap: _launchURL(),
              onTap: () async{
                const url = 'https://pradymagal.github.io/BayAirea';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            Divider(color: Colors.grey,),
        new ListTile(
          trailing:  Icon(Icons.linear_scale),
          title: Text("Our Scale"),
          ),
          Divider(color: Colors.grey),
        new ListTile(
          trailing:  Icon(Icons.more),
          title: Text("Learn more about 2.5 AQI air particles"),
           onTap: () async{
              const url = 'https://airnow.gov/index.cfm?action=aqibasics.particle';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
        ),
        
        ]

      ), 
    );
  }
}
// _launchURL() async {
//   const url = 'https://flutter.io';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }


