import 'package:flutter/material.dart';
import '../main.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Second PAge"),
      ),
      
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Navigator.pop(context,MaterialPageRoute(builder:(context)=>MyApp()));
            Navigator.push(context, MaterialPageRoute(builder:(context)=>MyApp()));
          },
          child: Text('Go back!'),
        ),
      ),
    );


  }
}
