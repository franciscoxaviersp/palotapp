import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'soon.dart';

class ParqueUA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Parque UA"),
      ),
      body: new PageView(

        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(height: 60.0, width: 200.0,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  color: Color(0x802196F3),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new Soon()));
                  },
                  child: Text('Reservar Parque', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
              new SizedBox(height: 60.0, width: 200.0),
              new Text('Total Lugares: 200', style: TextStyle(fontSize: 20)),
              new Text('Lugares Livres: 53', style: TextStyle(fontSize: 20)),
              new Text('Portadores de Deficiências: 5', style: TextStyle(fontSize: 20)),
              new Text('Carros Elétricos: 6', style: TextStyle(fontSize: 20)),
              new Text('GPL: 0', style: TextStyle(fontSize: 20)),
              new Text('Uso Geral: 42', style: TextStyle(fontSize: 20)),

              //BUTTON
              new SizedBox(height: 60.0, width: 200.0),
              new SizedBox(height: 60.0, width: 200.0,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  color: Color(0x802196F3),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new Soon()));
                  },
                  child: Text('Pagar Parque', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
              new SizedBox(height: 20.0, width: 200.0),
              new Text('Horários e Preços', style: TextStyle(fontSize: 20)),
              new Text('Seg-Sext 09:00-17:00   1€', style: TextStyle(fontSize: 20)),
              new Text('Seg-Sext 17:00-20:00   0.50€', style: TextStyle(fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }
}