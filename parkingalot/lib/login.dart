import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parkingalot/homepage.dart';
import 'package:parkingalot/soon.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
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

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _username = "";
  String _password = "";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

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

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
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
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _username and _password

  void _loginPressed () {
    String url = 'http://192.168.43.60:5000/login?user=$_username';
    print('The user wants to log in $_username and $_password');

    Future<String> makeRequest() async {
      var response = await http.get(Uri.encodeFull(url));
      var validResponse;
      if(response.statusCode>=200 && response.statusCode<=400){
        validResponse=jsonDecode(response.body);
        print(validResponse);
        //add password encryption
        print(validResponse['password']);
        if (validResponse['exist_error'] != "false"){
          _showDialogLoginUsername(context);
        }else if(validResponse['password'] != _password){
          _showDialogLoginPassword(context);
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(null)),
          );
        }

      }
      else{
        throw new Exception("Error while fetching data");
      }
    }
    makeRequest();
  }

  void _createAccountPressed () async{
    String url = 'http://192.168.43.60:5000/createUser';
    print('The user wants to create an accoutn with $_username and $_password');
    Map map = {
      "user": _username,
      "password": _password
    };
    print(map);
    var validUser;
    var response = await http.post(Uri.encodeFull(url),headers: {"Content-Type": "application/json"}, body: utf8.encode(jsonEncode(map)) );

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
      throw new Exception("Error while fetching data");
    }
  }

}

_showDialogCreateUsername(context){
  showDialog(
    context:context,
    builder: ( BuildContext context){
      return AlertDialog(
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
_showDialogLoginPassword(context){
  showDialog(
      context:context,
      builder: ( BuildContext context){
        return AlertDialog(
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

_showDialogCreateSuccess(context){
  showDialog(
      context:context,
      builder: ( BuildContext context){
        return AlertDialog(
          title: new Text("Account created with success!"),
          actions: <Widget>[
            new FlatButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: new Text("Proceed to login"),

            ),
          ],
        );
      }
  );
}