import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const oneSecond = Duration(seconds: 1);

class AirData{


Future<String> airQuality() async{
  //This returns a string 
  var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
    var response =  await http.get(url);//Parses it
   if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var aqi = jsonResponse['results'][0]['PM2_5Value'];
      Future.delayed(oneSecond, () => aqi);
      String output = aqi;
      return output;
   }
   else{
     return "Could not connect to server";
   }
  }

  //Gets the label/name of sensor
  Future<String> sensorName() async{
    var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
    var response =  await http.get(url);//Parses it
   if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var name = jsonResponse['results'][0]['Label'];
      String output = name;
      return output;
   }
   else{
     return "Could not connect to server";
   }
  }

   Future<String> tempF() async{
    var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
    var response =  await http.get(url);//Parses it
   if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var temp = jsonResponse['results'][0]['temp_f'];
      String output ="Temperature(F): "+temp;
      return output;
   }
   else{
     return "Could not connect to server";
   }
  
  }

}


/* 
  What we have so far: Air quality in AQI, sensor name, temperature in f, city name,
  
  Things we need:
  The info cards need to change colors, if you look on the bottom of home.dart, you'll see I tried to get it to work, and gave up, here is my problem:
      -I don't know how to convert String to int in dart
        [-]As a result, the app won't know what color to assign the Card, 
      -Yes, I tried subsituting "Future<String>" with Future<int> but it does not work
      -Also, when I tried to use the void on the bottom of home.dart like this:

    Future<Color> colorTest() async{ 
    int thing = 0;
    Color indicator = Colors.transparent;
    if(thing <= 50){
      indicator = Colors.greenAccent;
    }

    return indicator;
  }
  -It told me that I can't assign Future<Color> to the parameter color:



  Solution Idea:
  -Make a variable that just stores the int converted air quality at the top of the program, and then use that in the void on the bottom of home.dart like this:
  Color colorTest(int set){ 
    int thing = set;
    Color indicator = Colors.transparent;
    if(thing <= 50){
      indicator = Colors.greenAccent;
    }

    return indicator;
  }
  -And then pass in the int converted version of Future<String>airQuality() as set

  SIDE NOTE:
  I will do my research as to what excat pm2.5 value is bad/good for pets/running/etc. later, but for now,

  If its good, return Colors.greenAccent
  If its meh, return Colors.yellowAccent
  If its a little worse than meh, return Colors.orangeAccent
  If its bad, return Colors.redAccent

  Once we get this done, we work on the string on the Card(For example, "The air quality should be good for pets" when the card is green, and "Keep pets inside as much as possible" when the card is red)




*/