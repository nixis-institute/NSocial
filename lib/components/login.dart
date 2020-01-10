import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common/function/requestLogin.dart';
class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState(); 
}


_getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("LastToken");
  //int counter = (prefs.getInt('counter') ?? 0) + 1;
  //print('Pressed $counter times.');
  print("token is "+token);
  return token;
  //await prefs.setInt('counter', counter);
}


class _LoginPageState extends State<LoginPage>
{
  
  final _User = TextEditingController();
  final _Pass = TextEditingController();

  _getAndSaveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await _getTokenFromHttp();
    await prefs.setString('jwt', token);
  }


Future<String> _getTokenFromHttp() async
{
  
    Map<String,String> body = {
      'username':_User.text,
      'password':_Pass.text
    };

    String url = "http://mybebo.pythonanywhere.com/api-token-auth/";
    final response = await http.post(url,body:body);
    print(response.body);
}

  void Submit()

  {
    print("clicked");
    _getAndSaveToken();

  }
  void CheckUser(){
  _getUserToken();
  }


  @override
  Widget build(BuildContext context)
  {
    final username = TextFormField(
      autofocus: false,
      controller: _User,
      // onSaved: (String value){ _User = value; },
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
    );



    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _Pass,
      // onSaved: (String value){ _Pass = value; },
      onEditingComplete: (){
        setState(() {
          
        });
      },
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
    );


    final loginbutton = Padding(padding: EdgeInsets.symmetric(vertical: 16),
      child:Material(
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.grey[100],
        child: MaterialButton(
          minWidth: 200,
          height:40,
          onPressed: (){
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            //CheckUser();
            requestLoginApi(context,_User.text,_Pass.text);
            
            // print(_User.text);
            // print(_Pass.text);
          },
          color: Colors.lightBlueAccent,
          child:Text("Log In",style: TextStyle(color:Colors.white)),
        ),



      )
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left:24,right:24),
          children: <Widget>[
            username,
            SizedBox(height: 20),
            password,
            SizedBox(height: 20),
            loginbutton
          ],
        ),
      )
    );

    return new Container();
  }

}