import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:parkingalot/reserva.dart';



class infoReserva extends StatefulWidget{
  @override
  infoReservaState createState() => infoReservaState();
}
// user defined function

class infoReservaState extends State<infoReserva> {

  @override
  Widget build(BuildContext context) {
    //Pop Up when Button "Terminar" is Pressed
    void _showEndDialog() {
      // flutter defined function
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Tem a certeza que pretende Terminar a Reserva?!", textAlign: TextAlign.center),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Voltar"),

                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new infoReserva())
                    );
                  },
                ),
                new FlatButton(
                  child: new Text("Confirmar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    }

    //Pop Up when Button "Cancelar" is Pressed
    void _showCancelDialog() {
      // flutter defined function
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Tem a certeza que pretende Cancelar a Reserva?!", textAlign: TextAlign.center),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Voltar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Confirmar"),
                  onPressed: () {
                    Navigator.of(context).pop( MaterialPageRoute(builder: (context) => new Reserva()));
                  },
                ),
              ],
            );
          }
      );
    }

    //Page Content
    final image = Hero(
      tag: 'hero',
      child: SizedBox(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Image(image:AssetImage('assets/hospital.jpg')),
              //SizedBox(height: 20),
              new Row(
                children: <Widget>[
                  new Text('\n  Estacionamento Centro Hospitalar Baixo Vouga')
                ],
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Cancelar',style: TextStyle(color: Colors.red),),
                      onPressed: () {
                        _showCancelDialog();
                      },
                    ),
                    FlatButton(
                      child: const Text('Terminar'),
                      onPressed: () {
                        _showEndDialog();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    var format = new DateFormat('HH:mm:ss dd-MM-yyy');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Reserva"),
      ),
      body: new SingleChildScrollView(
          //padding: const EdgeInsets.symmetric(horizontal: 50.0),
         // padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              image,
              /*
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
              */
              new SizedBox(height: 10.0, width: 200.0),
              ListTile(
                title: Text('Data Inicio: ', style: TextStyle(fontSize: 20)),
                trailing: Text(' ${format.format(DateTime.now())}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15))
              ),
              new Divider(),
              new SizedBox(height: 5.0, width: 200.0),
              ListTile(
                  title: Text('Data Fim: ', style: TextStyle(fontSize: 20)),
                  trailing: Text('${format.format(DateTime.now())}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15))
              ),
              new Divider(),
              new SizedBox(height: 5.0, width: 200.0),
              ListTile(
                  title: Text('Valor Gasto: ', style: TextStyle(fontSize: 20)),
                  trailing: Text('0,00€',textAlign: TextAlign.center,style: TextStyle(fontSize: 15))
              ),
              new Divider(),
              ListTile(
                  subtitle: Text('Preço por hora: 0.05€'),
              ),

              new SizedBox(height:10)
            ],
          )
      ),

    );

  }
}