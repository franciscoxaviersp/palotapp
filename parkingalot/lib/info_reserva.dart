import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_a_lot/soon.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:parking_a_lot/reserva.dart' as a;

class infoReserva extends StatefulWidget{
  @override
  infoReservaState createState() => infoReservaState();
}
// user defined function

class infoReservaState extends State<infoReserva> {

 // DateTime sdate;
  //DateTime stime;
  //DateTime edate;
  //DateTime etime;
  //DateTime now = DateTime.now();


  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Reserva efetuada!"),
              content: new Text("Encontra-se em tempo de reserva!\n\nSerá descontado um valor a cada hora!"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Continuar"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new Soon())
                    );
                  },
                ),
              ],
            );
          }
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Reservar Lugar"),
      ),
      body: new SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),

                //color: Color(0x802196F3),
                height: 60.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0x802196F3),
                ),
                child: new Text("Estacionamento Centro Hospitalar Baixo Vouga",
                  textAlign: TextAlign.center,
                  style :TextStyle( fontSize: 15, color: Colors.white),
                ),
              ),

              new SizedBox(height: 60.0, width: 200.0),
              new Text('A sua reserva terá inicio a partir de: ', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              SizedBox(height: 10),
              Text(' ${DateTime.now().toString()}'),

              new Divider(),
              new Text('Data de fim de reserva:', style: TextStyle(fontSize: 20),  textAlign: TextAlign.center),
              //BUTTON

              new SizedBox(height:10)
            ],
          )
      ),

    );
  }
}