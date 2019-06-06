import 'package:flutter/material.dart';
import 'settings.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'air_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



String aqi2_5 = "";
String mult = "";
String label = "";
String humidity= "";
double aqiInt = -1;

void startUp()async{ //Sets up the variables
  AirData a1 = new AirData();
  aqi2_5 = await a1.airQuality();
  label =await a1.sensorName();
  humidity =await a1.humidity();
  aqiInt = double.tryParse(aqi2_5);
 }

class HomePage extends StatefulWidget {
 @override
 _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage>{
 @override
  

 Widget build(BuildContext context){
   startUp();
  final screenSize = MediaQuery.of(context).size;

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
            // onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage())),
            // onTap: (){
            //   //super.initState();
            //   Future.delayed(Duration(seconds: 1),(){
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
            //   });
            // },
        ),
        new ListTile(
          trailing:  Icon(Icons.help),
          title: Text("What am I looking at?"),
          onTap: (){
           showDialog( context: context, child: 
            new AlertDialog(
              title: new Text("Tutorial", textAlign: TextAlign.center,), 
              titlePadding: EdgeInsets.only(top: 10, bottom: 5),
              // content: new ListView(),
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: new Scaffold(
               
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: (){Navigator.of(context).pop();},
                )
              ],
              
            )
           );
          },
        ),

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
        maskCard(aqiInt),
        petCard(aqiInt),
        outCard(aqiInt),
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[

           new RaisedButton(
             child: const Icon(Icons.refresh, color: Colors.white,),
             color: Colors.blue[600], 
             shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
             elevation: 5.0,
             splashColor: Colors.blueGrey, 
             onPressed: ()async{
                AirData a1 = new AirData();
                String aqi2_5U =await a1.airQuality();
                String labelU =await a1.sensorName(); //DO NOT MODIFY. I found out the hard way that there are hundreds of ways of reframing this code that might seem like they work, but this is the only way that actually works
                String humidityU =await a1.humidity();
                double aqiIntU = double.tryParse(aqi2_5U);
                setState(() { //This lets the framework know that there is a change in variables and assigns the variables to updated versions at the same time
                  aqi2_5 =aqi2_5U;
                  label =labelU;
                  humidity =humidityU;
                  aqiInt = aqiIntU;
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
           leading: Icon(Icons.cloud), //Is there any data that better fits here? Let me know(For example humidity and pressure, the sensors provide that too)
           title: new Text(humidity,style: new TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
         )
       ],
     ),
     ),
   );
  
  
 }


}

 Card petCard(double set){ //I found out you can return Cards, so we can take advantage of this and make cleaner code 
  Color indicator = Colors.grey;
  String userText = "No Data";
  double size = 12; //We need this so we can set the size according to how long the string is, some descriptions might require more or less space

  if(set < 13){
     indicator = Colors.greenAccent;
     userText = "Air quality is safe for pets";
     size = 15;
   }
   else if(set >= 13 && set <= 40){
     indicator = Colors.yellowAccent;
     userText = "Air quality is moderate, most pets will be fine";
   }
   else if(set >= 40 && set <= 55){
     indicator = Colors.orangeAccent;
     userText = "Minimize your Pet's outdoor time";
   }
   else if(set >= 55 && set <= 100){
     indicator = Colors.redAccent;
     userText = "All pets must be kept indoors";
   }
   else if(set >= 100){
     indicator = Colors.purple;
     userText = "Air Quality is hazardous for pets, check air filter and close windows";
     size = 10;
   }
   else if(set == -1){
     indicator = Colors.grey;
     userText ="Click Refresh";
   }

   return new Card(
     color: indicator, //The color we set before
     child: new Row(
        children: <Widget>[
          new Icon(Icons.pets, color: Colors.black,size: 75),
          new Text(userText, style: new TextStyle(fontSize: size),),//Passes in the text we set before along with the font size
        ],
     ),
   );

 }


 Card maskCard(double set){ //I found out you can return Cards, so we can take advantage of this and make cleaner code 
  Color indicator = Colors.grey;
  String userText = "No Data";
  double size = 12; //We need this so we can set the size according to how long the string is, some descriptions might require more or less space

  if(set < 12){
     indicator = Colors.greenAccent;
     userText = "Open those windows and enjoy the air!";
     size = 13;
   }
   if(set > 12 && set <= 35.4){
     indicator = Colors.yellowAccent;
     userText = "Air quality is moderate, unusually sensitive groups may experience problems";
     size = 10;
   }
    if(set > 35.4 && set <= 55.4){
     indicator = Colors.orangeAccent;
     userText = "Air quality is unhealthy for sensitive groups(Asthamatics, Elderly, etc.)";
     size = 10;
   }
    if(set > 35.4 && set <= 55.4){
     indicator = Colors.orangeAccent;
     userText = "Air quality is unhealthy for sensitive groups(Asthamatics and Elderly need a mask)";
     size = 10;
   }
    if(set > 55.4 && set <= 150.4){
     indicator = Colors.redAccent;
     userText = "Air quality is unhealthy, wear a mask";
     size = 12;
   }
   if(set > 150.4 && set<=250.4 ){
     indicator = Colors.red[900];
     userText = "Air quality is very unhealthy, wear a mask";
     size = 12;
   }
   if(set > 250.4 ){
     indicator = Colors.purple;
     userText = "Air quality is Hazardous, wear a mask, close all windows and check air filter";
     size = 11;
   }

   const IconData(0xe9a9, fontFamily: 'MyFlutterApp');

   return new Card(
     color: indicator, //The color we set before
     child: new Row(
        children: <Widget>[
        new Icon(IconData(0xe800, fontFamily: 'MyFlutterApp'), color: Colors.black,size: 75),
        // new Column(),
        new Text(userText, style: new TextStyle(fontSize: size),),//Passes in the text we set before along with the font size
        ],
     ),
   );

 }

Card outCard(double set){ //I found out you can return Cards, so we can take advantage of this and make cleaner code 
  Color indicator = Colors.grey;
  String userText = "No Data";
  double size = 12; //We need this so we can set the size according to how long the string is, some descriptions might require more or less space

  if(set < 12){
     indicator = Colors.greenAccent;
     userText = "Enjoy outdoor activities"; //use my examples above, everything else is setup, this is how it should look
     size = 15;
   }
   //Fill in more if statements here based on the scale


   return new Card(
     color: indicator, //The color we set before
     child: new Row(
        children: <Widget>[
        new Icon(FontAwesomeIcons.footballBall,color: Colors.black,size: 75),
        new Text(" "+userText, style: new TextStyle(fontSize: size),),//Passes in the text we set before along with the font size
        ],
     ),
   );

 }



 /*
      Homework, use my petCard example above to compleyte cards for the overall card, and the outdoor activities card.
      
      I have set you up the other two cards, fill in the if statements, and please do not use the same scale as the pet card, what is healthy for a dog vs a person running outside is very different

      You will need to do more research in this homework than code, please get reliable sources and cite them below

      

      Pet sources:
      -http://weliveinaflat.com/blog/singapore-haze-dog/

      Mask Sources:
      
      Outdoor sources:
      

      Overall Source:
      -https://aqicn.org/faq/2013-09-09/revised-pm25-aqi-breakpoints/


  */



