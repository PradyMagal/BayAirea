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

  Widget build(BuildContext context){

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
              onTap: () async{

                //var x = await jsonTest("Ferrari"); //Change the parameter and see how many results google has
                var y = await sensorTest(); //DO NOT MODIFY

                showDialog(context: context, child:

                  new AlertDialog(
                    title: new Text("JSON Test"), //DO NOT CHANGE ANY OF THIS
                    content: new Text(y),
                  )

                );
              }
            ),

            new ListTile( //Brings user to our rather boring settings page 
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

Future<String> jsonTest(String user) async{ 
    var url = "https://www.googleapis.com/books/v1/volumes?q={"+user+"}"; //This obtains a URL with what ever string you pass in as a search query
    var response =  await http.get(url);                  //Parses it
    var jsonResponse = convert.jsonDecode(response.body); //More parsing/decoding stuff
    var itemCount = jsonResponse['totalItems']; //This stores the amount of results into a variable
    String output = "Google found: $itemCount books about/matching "+user; //Prettily put together our data
    return output; //returns the string we created
}

/*

Ok, So I've found out how to get the purple air JSON data and display it as an alert...

Try and get it to display the live air quality reading by monday, in order to to this, modify the mapV variable below, DO NOT TOUCH ANYTHING ELSE

It should display whatever the mapV variable is set when you click on the side menu tap "Location 1"(there is a small delay)



*/

Future<String> sensorTest() async{
  var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
  var response =  await http.get(url);//Parses it
  if( response.statusCode == 200){
    var jsonResponse = convert.jsonDecode(response.body);
    var mapV = jsonResponse['mapVersion']; //This is gets the map version, should return 0.72
    String output = "Map Version: "+mapV;
    return output;
  }
  else{
    return "Something is wrong";
  }
  

}





