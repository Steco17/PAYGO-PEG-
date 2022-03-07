
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white70, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
        ),
      child: _isLoading? const Center(child: CircularProgressIndicator()) :ListView(
        children: [
          headerSection(),
          textSection(),
          buttonSection(),
        ],
      ),
    ),
    );

  }
  Container headerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text("PAYGO-Agents", style: TextStyle(color: Colors.white)),
    );
  }

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          txtUsername("Agent Name", Icons.email),
          const SizedBox(height: 30.0,),
          txtPassword("Password", Icons.lock),

        ],
      )
    );
  }

  TextEditingController agentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  TextFormField txtUsername(String title, IconData icon){
    return TextFormField(
      controller: agentController,
      style: const TextStyle(color: Colors.black45),
      decoration: InputDecoration(
        hintText: title,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          icon: Icon(icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0)
          )
      ),
    );
  }

  TextFormField txtPassword(String title, IconData icon){
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: const TextStyle(color: Colors.black45),
      decoration: InputDecoration(
          hintText: 'Agent Name',
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          icon: Icon(icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0)
          )
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: (){
          setState(() {
            _isLoading = true;
          });
          signIn(agentController.text, passwordController.text);
        },
        color: Colors.black87,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        child: const Text("sign In", style: TextStyle(color: Colors.white70),),
      ),
    );
  }



   signIn(String username, String password)async {
    ///creating the sing in function which will get the username and passwords from the
     ///login form and sends it va the longin api lin to the server which will in turn authenticate
     ///the agent and return an authorization code. this code will be stored to keep the agent logged in
     ///after the token returned, the home page is opened.
    Map data = {
      'username': username,
      'password': password
    };
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var  url=
    Uri.parse('https://paygoapp.herokuapp.com/api/v1/dj-rest-auth/login/');

    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password
        }),
    );

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      var token = jsonData['key'];
    //  print(token);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", token);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()), (route) => false);
        
      });
    }
    else{
      _isLoading = false;
      throw Exception(response.body);    }

   }


}

