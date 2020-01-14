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

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isSubmit = false;
  bool isWrong = false;

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
  void initState(){
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();

  }

  Widget build(BuildContext context)
  {
    final username = TextFormField(
      onTap: (){
        setState(() {
        isWrong = false;  
        });
      },
      autofocus: false,
      controller: _User,
      // onSaved: (String value){ _User = value; },
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email'
        // borderr: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),



    );

    _sendToServer(context,username,password)
      async {
        var x = await requestLoginApi(context,username,password);
        if(x==null){
          setState(() {
            isWrong = true;
            isSubmit = false;
          });
        }
        // print("this is ");
        // print(x);
      }


    final password = TextFormField(
      autofocus: false,
      obscureText: !isPasswordVisible,
      controller: _Pass,
      // onSaved: (String value){ _Pass = value; },
      onEditingComplete: (){
        setState(() {
          
        });
      },
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible
          ?Icons.visibility
          :Icons.visibility_off),
          
          onPressed: (){
            setState(() {
              isPasswordVisible = !isPasswordVisible;
              // isWrong = false;
            });
          },
        )
        
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
      onTap: (){
        setState(() {
        isWrong = false;  
        });
        
      },
    );


    final loginbutton = Padding(padding: EdgeInsets.symmetric(vertical: 16),
      child:Material(
        borderRadius: BorderRadius.circular(30),
        // shadowColor: Colors.grey[100],
        borderOnForeground: true,
        child: MaterialButton(
          minWidth: 200,
          height:40,
          onPressed: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            //CheckUser();
 
            // var x = await requestLoginApi(context,_User.text,_Pass.text);
            setState(() {
              isSubmit = true;
            });
            _sendToServer(context,_User.text,_Pass.text);
            setState(() {
              isSubmit = true;
            });
            // if(x==null){
            //   isSubmit = true;
            // }
          },
          color: Colors.lightBlueAccent,
          // child:Text("Log In",style: TextStyle(color:Colors.white)),
          // child: CircularProgressIndicator(strokeWidth: 2,),

          child: isSubmit
          ?          
          Container(
            height: 25,
            width: 25,
            // child: Text("Login in"),
            child: CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation(Colors.white),),
          ):Text("Login",style:TextStyle(color:Colors.white)),
          

          // child:Text("Login",style:TextStyle(color:Colors.white))
          // Container(
          //   height: 25,
          //   width: 25,
          //   // child: Text("Login in"),
          //   child: CircularProgressIndicator(strokeWidth: 3,),
          // ),


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
            Text("Login In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height:50 ,),
            username,
            SizedBox(height: 20),
            password,
            SizedBox(height: 20),
            loginbutton,
            SizedBox(height: 10,),
 
            isWrong?            
              Container(
                child:  Text("email or password is wrong",textAlign: TextAlign.center, style: TextStyle(color: Colors.red),) 
              ):
              SizedBox(height: 1,)
            


          ],
        ),
      )
    );

    return new Container();
  }

}