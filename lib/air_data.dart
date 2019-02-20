import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AirData{

Future<String> sensorTest() async{
    var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
    var response =  await http.get(url);//Parses it
   if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var aqi = jsonResponse['mapVersion']; //Kai, there is no need to get thingspeak api involved in this, just modify this line of code so that it the variable AQI actually displays the aqi
      String output = "Map Version: "+aqi;
      return output;
   }
   else{
     return "Something is wrong";
   }
  }


}
  

/* Message to Kai:

This really isn't that complicated, do not work ahead, and just do what I say, there is no rush to do this, so please don't waste your time,

Your Job: Just modify the code (where my comment is) above, to make it display "v", the live 2.5 aqi reading

If you get stuck, use this:

With love and regards, 

-Pradyun
*/