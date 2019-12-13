
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingalot/signin.dart';
import 'package:parkingalot/homepage.dart';
import 'utils.dart';

class Profile extends StatelessWidget {
  final User user;
  final bool isReg;

  Profile(this.user): isReg=(user is Regular), super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(user,false))
              );
            }),
        title: Text("Perfil"),
      ),
      body: new Container(
        //padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Container(
              color: Color(0xff455a64),
              child: new Column(
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(top:20.0),
                        child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100,
                        )
                      )
                    ],
                  ),
                  new Align(
                    alignment: Alignment.centerRight,
                    child: isReg?new Container(
                      padding: EdgeInsets.only(bottom: 8,right:8),
                      child: new Text(
                        '${(user as Regular).credit.toString()}€',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      )
                    ):new Container(),
                  ),
                  new Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: new Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                      )
                    )
                  )
                ],
              )
            ),
            new Container(
              padding: EdgeInsets.only(top:16.0,bottom:16),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Container(
                      padding: EdgeInsets.only(bottom:12,left:20),
                      child: new Text(
                        'Email: ${user.email}',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Container(
                      padding: EdgeInsets.only(bottom:12,left:20),
                      child: new Text(
                        'Telemóvel: ${user.phone}',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              )
            ),
            _getButtons(),
            new Container(
              padding: EdgeInsets.only(top:20),
              child: new RaisedButton(
                child: new Text('Logout'),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _getButtons() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new RaisedButton(
            child: new Text(
              isReg?'Favoritos':'Parques Registados',
              style: TextStyle(fontSize:20)
            ),
            onPressed: () {
              //TODO got to park list
            },
          ),
        ),
        isReg?new Expanded(child: _getReservationButton()):new Container()
      ],
    );
  }

  Widget _getReservationButton() {
    return ((user as Regular).reservation.lat==0 && (user as Regular).reservation.lon==0)?
      new RaisedButton(
        child: new Text('Nenhuma Reserva', style: TextStyle(fontSize:20)),
        onPressed: () => null,
      ) :new RaisedButton(
        child: new Text(
            'Reserva',
            style: TextStyle(fontSize:20)
        ),
        onPressed: () {
          //TODO got reservation
        }
    );
  }

}
