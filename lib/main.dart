import 'package:flutter/material.dart';
import 'package:bay_airea/util/AirData.dart';
import 'package:bay_airea/pages/home.dart';


void main() async {
  AirData a = await AirData.create();

  runApp(new MaterialApp(
    theme: new ThemeData(),
    home: new HomePage(), //Runs home page as the first page for the user
  ));


}