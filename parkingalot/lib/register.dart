import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utils.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),*/
        title: Text("Register"),
      ),
      body: new RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _phoneFilter = new TextEditingController();
  String _username = "";
  String _password = "";
  String _email = "";
  String _phone = "";
  bool _type = false;
  //String url = 'http://192.168.43.60:5000/';
  String url = 'http://10.0.2.2:5000/';

  _RegisterPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
    _emailFilter.addListener(_emailListen);
    _phoneFilter.addListener(_phoneListen);
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

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _phoneListen() {
    if (_phoneFilter.text.isEmpty) {
      _phone = "";
    } else {
      _phone = _phoneFilter.text;
    }
  }

  void _goToLogin() async {
    Navigator.pop(context);
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
    String result3="";
    String result4="";

    return new Container(
      child: SingleChildScrollView(
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
            ),
            new Container(
              child: new TextField(
                controller: _emailFilter,
                decoration: new InputDecoration(
                    labelText: 'Email'
                ),
                onSubmitted: (String str){
                  setState((){
                    result3 = result3 + '\n' + str;
                  });
                  _emailFilter.text = "";
                },
              ),
            ),
            new Container(
              child: new TextField(
                controller: _phoneFilter,
                decoration: new InputDecoration(
                    labelText: 'Número Telemóvel'
                ),
                onSubmitted: (String str){
                  setState((){
                    result4 = result4 + '\n' + str;
                  });
                  _phoneFilter.text = "";
                },
              ),
            ),
            new Text("Proprietário"),
            new Checkbox(
              value: _type,
              onChanged: (bool value) {
                setState(() {
                  _type=value;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
        child: new Column(
            children: <Widget>[
              new RaisedButton(
                key: Key('regbtn'),
                child: new Text('Create an Account'),
                onPressed: _createAccountPressed,
              ),
              new FlatButton(
                key: Key('gotolog'),
                child: new Text('Já tem conta? Clique aqui para entrar.'),
                onPressed: _goToLogin,
              )
            ]
        )
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _username and _password

  void _createAccountPressed () async{
    String post = url+'createUser';
    print('The user wants to create an accoutn with $_username and $_password');
    Map map = {
      "user": _username,
      "password": _password,
      "email": _email,
      "phone": _phone,
      "especial": _type?"true":"false"
    };
    print(map);
    var validUser;
    var response = await http.post(Uri.encodeFull(post),headers: {"Content-Type": "application/json"}, body: utf8.encode(jsonEncode(map)) );

    if(response.statusCode>=200 && response.statusCode<=400){
      validUser=jsonDecode(response.body);
      if (validUser['exist_error'] == "false"){
        _showDialogCreateUsername(context);
      }
      else{
        _showDialogCreateSuccess(context);
      }
    }
    else{
      _conectionFailure(context);
      //throw new Exception("Error while fetching data");
    }
  }

  _showDialogCreateUsername(context){
    showDialog(
        context:context,
        builder: ( BuildContext context){
          return AlertDialog(
            key: Key('userexistsAlert'),
            title: new Text("Username invalid!"),
            content: new Text("Username already exists"),
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
  _showDialogCreateSuccess(context){
    showDialog(
        context:context,
        builder: ( BuildContext context){
          return AlertDialog(
            key: Key('createdAlert'),
            title: new Text("Account created with success!"),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  _goToLogin();
                },
                child: new Text("Continuar para o login"),

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