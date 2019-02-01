import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return new Material(
    color: Colors.tealAccent[100],
    child: new InkWell(
      onTap: (){
        print("Tappity-Tap!");
      },
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.warning, color: Colors.white,size: 150,),
            new Text("Under Construction", style: new TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold),),
            new Text("Bay Airea is currently undergoing maintenence, please check back later", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
          ],
        ),
    ),
  );
  }
}