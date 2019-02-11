import 'package:flutter/material.dart';
import 'package:bay_airea/pages/settings.dart';
import 'package:bay_airea/pages/landing_page.dart';
import 'package:bay_airea/util/AirData.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();

}
class _HomePageState extends State<HomePage>{
  @override

  Widget build(BuildContext context) {



    //TODO: Why have the same scaffold in multiple classes?
    return new Scaffold(
      appBar: new AppBar(title: Text("Bay Airea"), backgroundColor: Colors.tealAccent[100],),

      drawer: new Drawer(
        child: new ListView(children: <Widget>[
            new ListTile(
              title: new Text("Menu" ,style: new TextStyle(fontSize: 25),),),
            new ListTile(
              title: new Text("Close Menu" ,style: new TextStyle(fontSize: 15),),
              leading: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context); //This closes the menu, and brings the user back to what he/she was on
              }),
            new ListTile(
              title: new Text("Location 1" ,style: new TextStyle(fontSize: 15),),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => LandingPage())),
            ),
            new ListTile( //Brings user to our rather boring settings page
              title: new Text("Settings" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.settings),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => SettingsPage())),
            )
          ],)

      ),

      body: new Container(
        child: Row(
          children: [
            new Container(
                alignment: Alignment.bottomLeft,
                child: RaisedButton.icon (
                  color: Colors.blue,
                  icon: Icon(Icons.refresh),
                  label: Text("Refresh"),
                  onPressed: () {
                    AirData.reloadData();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                  }
            )),
            new Container (
              alignment: Alignment.center,
              child: Card (
                child: Column (
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                    /*ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text(AirData.currentSensor),
                      subtitle: Text("Change location in settings.")
                    ),*/
                    new Padding(
                      padding: EdgeInsets.only(top: 20)
                    ),
                    new Text("     Current Sensor: " + AirData.currentSensor + "    "),
                    new Text("Temperature (F): ${AirData.temperatureF}"),
                    new Text("Humidity (%): ${AirData.humidityPercent}"),
                    new Text("Particles: ${AirData.particles}"),
                    new Padding(
                        padding: EdgeInsets.only(bottom: 20)
                    )
                  ]
                )
              )
            )
          ]
        ),
      ),

    );
  }

}




