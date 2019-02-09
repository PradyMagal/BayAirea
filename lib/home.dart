import 'package:flutter/material.dart';
import 'settings.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage>{
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
              leading: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context); //This closes the menu, and brings the user back to what he/she was on
              }
            ),

            new ListTile(
              title: new Text("Location 1" ,style: new TextStyle(fontSize: 15),),
              onTap: () {
                jsonTest("Ferrari"); //Change the parameter to see how many results google spits out
              }
            ),

            new ListTile( //Brings iser to our rather boring settings page 
              title: new Text("Settings" ,style: new TextStyle(fontSize: 15),),
              trailing: new Icon(Icons.settings),
              onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => SettingsPage())),
            )

          ],

        )

      ),

      body: 
      new Center(
        child: new Text("This is where the content goes"),
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

void jsonTest(String user) async{ 
    var url = "https://www.googleapis.com/books/v1/volumes?q={"+user+"}"; //This obtains a URL with what ever string you pass in as a search query
    var response =  await http.get(url);                  //Parses it
    var jsonResponse = convert.jsonDecode(response.body); //More parsing/decoding stuff
    var itemCount = jsonResponse['totalItems']; //This stores the amount of results into a variable
    print("Google found: $itemCount books about/matching "+user); //This prints out our result prettily in the debug console
}



