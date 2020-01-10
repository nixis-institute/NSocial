import 'dart:core';

import 'package:Bebo/screens/detailPage.dart';
import 'package:flutter/material.dart';
import 'components/file.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'components/services.dart';
//import 'package'
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'components/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class SharedPreferencesHelper{
  // static final String key = "";
  static Future<String> getToken() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString("LastToken");
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //SharedPreferences preferences = new SharedPreferences.getInstance();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // final String = SharedPreferencesHelper.getToken();
  
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
      //home: Homepg()
      routes: <String,WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => Homepg(),
        "/LoginScreen": (BuildContext context) => LoginPage(),
      },
      // String token = SharedPreferencesHelper.getToken()
      // SharedPreferencesHelper.getToken();
      // home:LoginPage()
      home: FutureBuilder<String>(
        future: SharedPreferencesHelper.getToken(),
        initialData: '',
        builder: (BuildContext context,AsyncSnapshot<String> snapshot){
          // print(snapshot.data);
          return snapshot.hasData
          ? Homepg() :
          LoginPage();
        },
      ),

    ),
    );    

  }
}

_gotoDetail(BuildContext context){
  print("going");
  Navigator.push(context ,MaterialPageRoute(builder: (context)=>SecondRoute()));
}


class Homepg extends StatelessWidget{
//myid VXNlclR5cGU6MQ==
// String mutation = """
//     mutation Post($uid:ID!)
//     {
//       postComment(comment:"sdkjhfkjdshfkds",uid:$uid,photoid:"ilksdjf")
//       {
//       comment{
//         comment
//         commentBy{
//           id
//           username
//         }
//         commentTime
//       }
//       }
//     }
//  """;



String query ="""
{
  allContext(first:5)
  {
    pageInfo{
    endCursor
    hasNextPage
    hasPreviousPage
    }    
    edges{
      node{
        id
        originalPhoto
        createdDate
        uploadBy{
          username
          profilePic{
            id
            profileThumbs
          }
        }
        comments{
          edges{
            node{
              id
              comment
              commentBy {
                id
              }
            }
          }
        }
        
      }
    }
  }
}

""";

// String query = """
// {
//   allContext(first:20){
//     edges{
//       node{
//         id
//         originalPhoto
//         createdDate
//         uploadBy{
//           username
// 					profilePic {
// 			  		id
//             profileThumbs
// 					}
//         }
//       }
//     }
//   }
// }

// """;




  @override
  Widget build(BuildContext context)
  {
    return   Scaffold(
        
        bottomNavigationBar: BottomAppBar(
          
          child: Padding(
            padding: EdgeInsets.all(10),
            child: 
                      Row(
            
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(

                child: Icon(Icons.home,size: 30,),
              ),
              Container(
                child: Icon(Icons.search,size: 30,),
              ),

              Container(
                child: Icon(Icons.chat,size: 30,),
              ),

              Container(
                child: Icon(Icons.account_circle,size: 30,),
              ),
          ],),
            
            )
          

          
          
          ),
        
        
        appBar: 
          
          AppBar(
            elevation: 10,
            centerTitle: true,
            backgroundColor: Colors.white,
            textTheme: TextTheme(title:TextStyle(color:Colors.orange[500],fontSize: 20)),

            // leading: InkWell(
            
            //   child:Icon(Icons.menu),
            //   ),

            
            

            title: 
            Center(
              child:              
              Icon(Icons.favorite,color: Colors.red[700],size:40),
            )            
            //   Center(
            //   child: Row(children: <Widget>[
            //     Icon(Icons.favorite,color: Colors.red[700],size:40),
            //     Text("Bebo"),
            //     Icon(Icons.favorite,color: Colors.red[700],size:40),
            //   ],),
            // ),
             

            
          
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
                  String name =  result.data["allContext"]["edges"][index]["node"]["uploadBy"]["username"];
                  String profile = result.data["allContext"]["edges"][index]["node"]["uploadBy"]["profilePic"]["profileThumbs"];
                  String date = result.data["allContext"]["edges"][index]["node"]["createdDate"];
                  List<dynamic> comments = result.data["allContext"]["edges"][index]["node"]["comments"]["edges"];
                  img = "http://mybebo.pythonanywhere.com/media/"+img;
                  String endCursor = result.data["allContext"]["pageInfo"]["endCursor"];
                  bool hasNextPage = result.data["allContext"]["pageInfo"]["hasNextPage"];

                return
                
                Padding(
                  child:
                  Column(
                    
                   children: <Widget>[
                     Container(
                    child:
                    ListTile(
                      leading: GestureDetector(
                            child: CircleAvatar(
                          backgroundImage: NetworkImage("http://mybebo.pythonanywhere.com/media/"+profile),
                          ),
                      ),
                      title: GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>DetailPage(img))),
                        // Navigator.push(context, MaterialPageRoute(builder:(_)=>PageOne("Page Two")));
                        child: Text(name,style: TextStyle(fontWeight:FontWeight.bold),)),
                      // subtitle: Text(date),
                      trailing: Icon(Icons.more_vert),
                      
                      contentPadding: EdgeInsets.only(left:10,right: 10),
                      ),
                      //color: Colors.grey[100],
                     ),
                     Container(
                       color: Colors.grey[100],
                       //child:Image.network(img),
                       child:FadeInImage.memoryNetwork(
                         placeholder:kTransparentImage,
                        image: img,

                       )
                     ),

                    Container(
                      color: Colors.grey[100],
                      child:
                      Column(
                          children: <Widget>[
                          Padding(
                            child:Row(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,color: Colors.orange[400],
                                ),
                                Icon(
                                  Icons.star,color: Colors.orange[300],
                                ),
                                Icon(
                                  Icons.star,color: Colors.orange[200],
                                ),
                                Icon(
                                  Icons.star,color: Colors.orange[100],
                                ),
                                Icon(
                                  Icons.star,color: Colors.orange[50],
                                ),

                              ],
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          
                          Container(
                            //padding: EdgeInsets.all(5),
                            child:Column(
                              children: <Widget>[
                                  for(dynamic item in comments) 
                                    Text(item)

                              ],
                            )
                          ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: 
                          TextField(
                            
                            textInputAction: TextInputAction.send,
                            maxLines: 10,
                            minLines: 1,
                            decoration: InputDecoration(
                                                            
                              //prefixIcon: Icon(Icons.add_circle),
                              border:InputBorder.none,
                              hintText: 'Comments....'
                            )),
                          )

                          

                          ],
                      )
                    )
                   ],                       
                  ),
                  padding:const EdgeInsets.only(bottom: 0),
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
