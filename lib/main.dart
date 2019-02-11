import 'package:flutter/material.dart';
import 'package:bay_airea/util/AirData.dart';
import 'package:bay_airea/pages/home.dart';


void main() {
  new AirData();

  runApp(new MaterialApp(
    theme: new ThemeData(),
    home: new HomePage(), //Runs home page as the first page for the user
  ));


}