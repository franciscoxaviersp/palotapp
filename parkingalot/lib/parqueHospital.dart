import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingalot/soon.dart';
import 'package:parkingalot/reserva.dart';
import 'package:url_launcher/url_launcher.dart';

class ParqueHospital extends StatefulWidget{
  @override
  ParqueHospitalState createState() => ParqueHospitalState();
}

class ParqueHospitalState extends State<ParqueHospital> {

  initState(){
    super.initState();
  }
  bool isPressed = false;
  _pressed() {
    var newVal = true;
    if (isPressed) {
      newVal = false;
    }
    else {
      newVal = true;
    }

    setState((){
      isPressed = newVal;
    });
  }
  @override
  Widget build(BuildContext context) {
  
   

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
                  new IconButton(icon: Icon(isPressed ? Icons.favorite: Icons.favorite_border), onPressed:()=> _pressed()),
                  new Text('\nAv. Padre Fernão de Oliveira\nGlória \n3810-164 Aveiro')
                ],
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Pagar'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new Soon()));
                        },
                    ),
                    FlatButton(
                        child: const Text('Reservar'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new Reserva()));
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Parque Hospital"),
      ),
      body: new SingleChildScrollView(
        //padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: new Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              new Divider(),
              const ListTile(
                title: Text('Total Lugares: 200'),
              ),


              new SizedBox(
                //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 100.0,
                width: 500.0,

               // decoration: BoxDecoration(
                child:
                 new ListView.builder(

                   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                   itemBuilder: (BuildContext context, int index) =>
                       EntryItem(data[index]),
                   itemCount: data.length,
                 ),

              ),

              new Divider(),
              
              new Text('Horários e Preços', style: TextStyle(fontSize: 20)),
              new Text('Segunda - Sexta',textAlign: TextAlign.left),
              const ListTile(
                subtitle: Text('09h00 - 17h00',textAlign: TextAlign.left),
                trailing: Text('\n1.00€'),
              ),
              const ListTile(
                subtitle: Text('17h00 - 20h00',textAlign: TextAlign.left),
                trailing: Text('\n0.50€'),
              ),
              const ListTile(
                subtitle: Text('20h00 - 09h00',textAlign: TextAlign.left),
                trailing: Text('\nGrátis'),
              ),
              new Text('Fins-de-Semana',textAlign: TextAlign.left),
              const ListTile(
                subtitle: Text('Todo o dia',textAlign: TextAlign.left),
                trailing: Text('\nGrátis'),
              ),
              //new Text('Horários e Preços', style: TextStyle(fontSize: 20)),
             // new Text('Seg-Sext 09:00-17:00   1€', style: TextStyle(fontSize: 20)),
              //new Text('Seg-Sext 17:00-20:00   0.50€', style: TextStyle(fontSize: 20)),
              //new SizedBox(height: 20.0, width: 200.0),
              new BottomAppBar(
                child:
                ListTile(
                  title: Text('Proprietário',textAlign: TextAlign.center),
                  subtitle: FlatButton.icon(
                      label: Text('MoveAveiro\n23440638',style: TextStyle(color: Colors.grey)),
                      icon: Icon(Icons.call,size:20),
                      onPressed: () => launch("tel://234406387"),
                  ),
                ),

              ),
            ],
          ),
      ),
    );
  }
}
class Entry {
  Entry(this.title,this.icon, [this.children = const <Entry>[]]);
  final IconData icon;
  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Lugares Livres: 53', Icons.local_parking,
    <Entry>[
      Entry('Portadores de Defeciências: 5',Icons.accessible),
      Entry('Carros Elétricos: 5',Icons.battery_charging_full),
      Entry('GPL: 2',Icons.local_gas_station),
      Entry('Uso Geral: 2',Icons.local_parking),
    ],

  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}