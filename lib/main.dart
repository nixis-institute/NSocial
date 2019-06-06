import 'package:flutter/material.dart';
import 'components/file.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'components/services.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
    client:client,
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage1(title: 'MY Page'),
      //home:MyHomePage1(),
      home: Homepg()
    ),
    );    

  }
}

_gotoDetail(BuildContext context){
  print("going");
  Navigator.push(context ,MaterialPageRoute(builder: (context)=>SecondRoute()));
}


class Homepg extends StatelessWidget{
String query = """
{
  allContext(first:20){
    edges{
      node{
        id
        originalPhoto
        uploadBy{
          username
					profilePic {
			  		id
            profileThumbs
					}
        }
      }
    }
  }
}""";

  @override
  Widget build(BuildContext context)
  {
    return   Scaffold(
        appBar: 
          AppBar(
            title: Text("home page"),
          ),
         body: Query(
           options: QueryOptions(document: query),
            builder: (QueryResult result,{VoidCallback refetch}){
              if(result.loading){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemBuilder: (BuildContext,int index){
                  //print(result.data["allContext"]["edges"][index]["node"]["originalPhoto"]);
                  String img = result.data["allContext"]["edges"][index]["node"]["originalPhoto"];
                  img = "http://mybebo.pythonanywhere.com/media/"+img;
                  return 
                  
                  ListTile(
                    
                      leading: CircleAvatar(backgroundImage: NetworkImage(img)),
                      title: Text(result.data["allContext"]["edges"][index]["node"]["id"]),
                      //subtitle: Text(img),
                      contentPadding: EdgeInsets.all(10),
                      onTap:(){
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(builder: (context)=>SecondRoute()));
                      }
                        
                        //_gotoDetail(context)
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondRoute()));
                       
                      
                    //Navigator.push(context, MaterialPageRoute(builder:(context)=>MyApp()));
                    );
                },
                itemCount: result.data["allContext"]["edges"].length,
              );
              
            },
         )
 
        );
  }

}

// Scaffold nnn = Scaffold(
//         appBar: 
//           AppBar(
//             title: Text("home page"),
//           ),
//          body: Query(
//            options: QueryOptions(document: query),
//             builder: (QueryResult result,{VoidCallback refetch}){
//               if(result.loading){
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                 itemBuilder: (BuildContext,int index){
//                   //print(result.data["allContext"]["edges"][index]["node"]["originalPhoto"]);
//                   String img = result.data["allContext"]["edges"][index]["node"]["originalPhoto"];
//                   img = "http://mybebo.pythonanywhere.com/media/"+img;
//                   return 
                  
//                   ListTile(
                    
//                       leading: CircleAvatar(backgroundImage: NetworkImage(img)),
//                       title: Text(result.data["allContext"]["edges"][index]["node"]["id"]),
//                       //subtitle: Text(img),
//                       contentPadding: EdgeInsets.all(10),
//                       onTap:(){
//                         Navigator.push(
//                           context, 
//                           new MaterialPageRoute(builder: (context)=>SecondRoute()));
//                       }
                        
//                         //_gotoDetail(context)
//                         //Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondRoute()));
                       
                      
//                     //Navigator.push(context, MaterialPageRoute(builder:(context)=>MyApp()));
//                     );
//                 },
//                 itemCount: result.data["allContext"]["edges"].length,
//               );
              
//             },
//          )
 
//         );

// }



Widget titleSection2 = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);

Widget titleSection = Container(
  padding: const EdgeInsets.all(30),
  child: Row(
    
    children: <Widget>[
      Expanded(child: 
      Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[

        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "Title of conte"
          ),
          
        ),
        Text(
          'Body of Context',
            style: TextStyle(color:Colors.green ),
        )
      ],
      ),
      ),
      Icon(
        Icons.access_time,
        color: Colors.orange[300],
        
      ),
      Padding(
        child: Text(
      '5:00',
      //style: Padding(bottom:9),
      ),
      padding:const EdgeInsets.only(left:7) ,
    ),

    ],
  ),
);


class MyHomePage1 extends StatelessWidget{
  //MyHomePage1({Key key, this.title}):super(key:key);
  @override
  Widget build(BuildContext context)
  {
      return Scaffold(
    appBar: AppBar(
      title: Text("FirstPage"),
    ),
    body: Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondRoute()));
        },
        child: Text('Go To Second Page'),
      ),
    ),
  );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter+=5;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        

      
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          RaisedButton(
            child: Text("Go to Another Page"),
            onPressed:() {
              Navigator.push(
              context, 
            MaterialPageRoute(builder: (context)=>SecondRoute())
            );
        }
          )


          ],
        ),





      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.


    );
  }
}
