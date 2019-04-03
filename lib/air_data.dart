import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const oneSecond = Duration(seconds: 1);

class AirData{
// var sensorID = ""; 
var url = "https://www.purpleair.com/json?show=15130";//A random sensor in mountain view
// var url = "https://www.purpleair.com/json?show=11733";//Use this for testing, this is a sensor in the US Embassy in New Dheli, air quality is terrible over there
// var url = "https://www.purpleair.com/json?show=15134"; //Idk where this is quality is usually meh here
Future<String> airQuality() async{
 //This returns a string
   var response =  await http.get(url);//Parses it
  if (response.statusCode == 200){
     var jsonResponse = convert.jsonDecode(response.body);
     var aqi = jsonResponse['results'][0]['PM2_5Value'];
    //  Future.delayed(oneSecond, () => aqi);
     String output = aqi;
     return output;
  }
  else{
    return "Could not connect to server";
  }
 }

 //Gets the label/name of sensor
 Future<String> sensorName() async{
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

  Future<String> humidity() async{
   var response =  await http.get(url);//Parses it
  if (response.statusCode == 200){
     var jsonResponse = convert.jsonDecode(response.body);
     var percent = jsonResponse['results'][0]['humidity'];
     String output ="Humidity: "+percent+"%";
     return output;
  }
  else{
    return "Could not connect to server";
  }
  }

}
