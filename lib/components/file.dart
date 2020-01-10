import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';

class SecondRoute extends StatelessWidget {
  @override
  //SecondRoute(data);
  final String id;
  SecondRoute({Key key, @required this.id}):super(key:key);
  Widget build(BuildContext context) {

    //String img = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      
      ),
      body:ListView(
        children: [

          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: 
              //NetworkImage(id)
              Image.network(id)
            ,

          )
          //NetworkImage(img);
        ],)
       


      // body: Center(




      //   child: RaisedButton(
      //     onPressed: () {
      //       //Navigator.pop(context,MaterialPageRoute(builder:(context)=>MyApp()));
      //       //Navigator.push(context, MaterialPageRoute(builder:(context)=>MyApp()));
      //       Navigator.pop(context);
      //     },
      //     child: Text('Go back!'),
      //   ),
      // ),
    );


  }
}
