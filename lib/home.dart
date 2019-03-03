import 'package:flutter/material.dart';
import 'settings.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'air_data.dart';

String aqi2_5 = "";
String mult = "";
String label = "";
String temp= "";
int aqiInt = 0;

void startUp()async{ //Sets up the variables
  
  AirData a1 = new AirData();
  aqi2_5 = await a1.airQuality();
  label =await a1.sensorName();
  temp =await a1.tempF();
  }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  

  Widget build(BuildContext context){
    startUp(); 

    return new Scaffold(
      appBar: new GradientAppBar(title: Text("Bay Airea"), backgroundColorStart: Colors.tealAccent[100], backgroundColorEnd: Colors.blueAccent[100],),
      drawer: new Drawer(

        child: new ListView(

          children: <Widget>[

            new ListTile(
              title: new Text("Menu" ,style: new TextStyle(fontSize: 25),),
            ),
            
            new ListTile(
              title: new Text("Close Menu" ,style: new TextStyle(fontSize: 15),),
              leading: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
              }
            ),

            new ListTile(
              title: new Text("Test" ,style: new TextStyle(fontSize: 15),), //For debugging only
              onTap: () async{

                startUp();


                showDialog(context: context, child:

                  new AlertDialog(
                    title: new Text("JSON Test"), //DO NOT CHANGE ANY OF THIS
                    content: new Text("Hello world"),
                  )

                );
              }
            ),

            new ListTile( 
              title: new Text("Settings" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.settings),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => SettingsPage())),
            )

          ],

        )

      ),

      body: 
      new Card(

        child: new Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
            child: new Text(aqi2_5, 
                style: new TextStyle(
                    color: new Color.fromARGB(255, 117, 117, 117),
                    fontSize: 45.0,
                    fontWeight: FontWeight.normal)),
          ),
          new Divider(
            color: Colors.grey,
          ),
          new Card(
            color: Colors.greenAccent, 
            child: new Row(
              children: <Widget>[
                new Icon(Icons.pets, color: Colors.black,size: 75),
                new Text("The air quality should be safe for pets"), 

            ],
            )
          ),
          new Card(
            color: Colors.yellowAccent, //This is the background color of the card
            child: new Row(
              children: <Widget>[
                new Icon(Icons.face, color: Colors.black,size: 75),
                new Text("Mask may be needed for those with sensitive lungs", style: TextStyle(fontSize: 11),), 
            ],
            )
          ),
           new Card(
            color: colorTest(),//This is what I'm thinking, a function that returns a color based on the AQI Value
            child: new Row(
              children: <Widget>[
                new Icon(Icons.directions_run, color: Colors.black,size: 75),
                new Text("Air quality is too poor to partake in outdoor activities", style: TextStyle(fontSize: 11)), 
            ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

            new RaisedButton( 
              child: const Icon(Icons.refresh, color: Colors.white,),
              color: Colors.blue[600], //I'm bad with colors, change it if you want but don't go too crazy
              shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
              elevation: 5.0,
              splashColor: Colors.blueGrey, //Again, bad with colors choose whatever looks good
              onPressed: ()async{
              AirData a1 = new AirData();
              String aqi2_5U =await a1.airQuality();
              String labelU =await a1.sensorName(); //DO NOT MODIFY. I found out the hard way that there are hundreds of ways of reframing this code that might seem like they work, but this is the only way that actually works
              String tempU =await a1.tempF(); //U Stands for updated
                setState(() { //This lets the framework know that there is a change in variables and assigns the variables to updated versions at the same time
                  aqi2_5 =aqi2_5U;
                  label =labelU;
                  temp =tempU;
                  
                });
                

              },
            ),

          ],

            
        ),
          
          Divider(
            color: Colors.grey,
          ),
          new ListTile( 
            leading: Icon(Icons.settings_input_antenna),
            title: new Text(label,style: new TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
          ),
         new ListTile(
            leading: Icon(Icons.location_city),
            title: new Text("Mountain View",style: new TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
          ),
          new ListTile(
            leading: Icon(Icons.wb_cloudy), //Is there any data that better fits here? Let me know(For example humidity and pressure, the sensors provide that too)
            title: new Text(temp,style: new TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
          )
        ],
      ),
      ),
    );
    
    
  }


  Color colorTest(){ //This works, but still not what we are looking for
    int thing = 0;
    Color indicator = Colors.transparent;
    if(thing <= 50){
      indicator = Colors.greenAccent;
    }

    return indicator;
  }
  
}