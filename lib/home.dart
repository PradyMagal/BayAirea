import 'package:flutter/material.dart';
import 'settings.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override

  Widget build(BuildContext context){

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
              title: new Text("Location 1" ,style: new TextStyle(fontSize: 15),),
              onTap: (){


                showDialog(context: context, child:

                  new AlertDialog(
                    title: new Text("JSON Test"), //DO NOT CHANGE ANY OF THIS
                    content: new Text("Hello World"),
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
            child: new Text("Gemello Park, Mountain View: (AQI reading goes Here)", //Replace "(AQI reading goes here)" with the actual AQI reading, obtain the variable from the air_data class
                style: new TextStyle(
                    color: new Color.fromARGB(255, 117, 117, 117),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
          ),
          new Divider(
            color: Colors.grey,
          ),
          new Card(
            color: Colors.greenAccent,
            child: new Row(
              children: <Widget>[
                new Icon(Icons.pets, color: Colors.grey,size: 75),
                new Text("The air quality should be safe for pets"), //This is a template as to what the app will look like, we will work on this LATER Kai

            ],
            )
          ),

        ],
      ),
      ),

    );

    
  }
}
//This is our JSON Test

/*
This is google's api on books

It searches through its data bases on books that matches the keyword passed into the curly brackets

Want to try for yourself, try this: https://www.googleapis.com/books/v1/volumes?q={donuts}
(Open the link in a browser tab and it will give you many results about donuts)
*/

Future<String> jsonTest(String user) async{ 
    var url = "https://www.googleapis.com/books/v1/volumes?q={"+user+"}"; //This obtains a URL with what ever string you pass in as a search query
    var response =  await http.get(url);                  //Parses it
    var jsonResponse = convert.jsonDecode(response.body); //More parsing/decoding stuff
    var itemCount = jsonResponse['totalItems']; //This stores the amount of results into a variable
    String output = "Google found: $itemCount books about/matching "+user; //Prettily put together our data
    return output; //returns the string we created
}








