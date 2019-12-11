import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkingalot/homepage.dart';
import 'package:parkingalot/register.dart';
import 'utils.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),*/
        title: Text("Login"),
      ),
      body: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _username = "";
  String _password = "";
  //String url = 'http://192.168.43.60:5000/';
  String url = 'http://10.0.2.2:5000/';

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _goToRegister() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    String result1="";
    String result2="";

    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              key: Key('userkey'),
              controller: _usernameFilter,
              decoration: new InputDecoration(
                  labelText: 'Username'
              ),
              onSubmitted: (String str){
                setState((){
                  result1 = result1 + '\n' + str;
                });
                _usernameFilter.text = "";
              },
            ),
          ),
          new Container(
            child: new TextField(
              key: Key('passkey'),
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              onSubmitted: (String str){
                setState((){
                  result2 = result2 + '\n' + str;
                });
                _usernameFilter.text = "";
              },
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
        child: new Column(
            children: <Widget>[
              new RaisedButton(
                key: Key('logbtn'),
                child: new Text('Log in'),
                onPressed: _loginPressed,
              ),
              new FlatButton(
                key: Key('gotoreg'),
                child: new Text('Não tem conta? Clique aqui para se registar.'),
                onPressed: _goToRegister,
              )
            ]
        )
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _username and _password

  void _loginPressed () {
    String post = url+'login?user=$_username';
    print('The user wants to log in $_username and $_password');

    void makeRequest() async {
      var response = await http.get(Uri.encodeFull(post));
      var validResponse;
      if(response.statusCode>=200 && response.statusCode<=400){
        validResponse=jsonDecode(response.body);
        print(validResponse);
        //add password encryption
        print(validResponse['password']);
        if (validResponse['exist_error'] != "false"){
          _showDialogLoginUsername(context);
          return;
        }else if(validResponse['password'] != _password){
          _showDialogLoginPassword(context);
          return;
        }
        else{
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );*/
          response = await http.get(Uri.encodeFull(post));
          if(response.statusCode>=200 && response.statusCode<=400){
            validResponse = jsonDecode(response.body);
            //TODO construct User (regular or Proprietary)
            var user;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(user)),
            );
          }
        }

      }
      //throw new Exception("Error while fetching data");
      _conectionFailure(context);
    }
    makeRequest();
  }

  _showDialogLoginPassword(context){
    showDialog(
        context:context,
        builder: ( BuildContext context){
          return AlertDialog(
            key: Key('badpassAlert'),
            title: new Text("Wrong password!"),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text("Close"),

              ),
            ],
          );
        }
    );
  }
  _showDialogLoginUsername(context){
    showDialog(
        context:context,
        builder: ( BuildContext context){
          return AlertDialog(
            key: Key('nouserAlert'),
            title: new Text("User doesn't exist!"),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text("Close"),

              ),
            ],
          );
        }
    );
  }

  _conectionFailure(context){
    showDialog(
        context:context,
        builder: ( BuildContext context){
          return AlertDialog(
            key: Key('connectionAlert'),
            title: new Text("Erro de ligação"),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text("Ok"),

              ),
            ],
          );
        }
    );
  }

}