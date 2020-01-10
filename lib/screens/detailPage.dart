import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget{
  @override
  final String link;
  DetailPage(this.link);

  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Details',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 25.0,
                color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        child: Hero(
          tag: this.link,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  
                  // alignment: Alignment.center,
                  image: NetworkImage(link),
                  fit: BoxFit.cover
                  )
                  ),
              height: 200.0,
              width: 200.0)))
      );
  }
}