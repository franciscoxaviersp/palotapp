import 'package:flutter/material.dart';
import 'dart:async';
import 'utils.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingalot/soon.dart';
import 'package:parkingalot/reserva.dart';
import 'package:parkingalot/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

final String url = "http://192.168.43.60:5000/";


class Parque extends StatefulWidget{
  Map park;
  User user;
  Parque(this.park,this.user):super();
  @override
  ParqueState createState() => ParqueState(park,user);
}

class ParqueState extends State<Parque> {
  Map park;
  User user;
  bool isPressed;
  ParqueState(this.park,this.user):super();
  initState(){
    super.initState();
    isPressed = (user.parks.contains(park["coords"]));
  }
  void _pressed() {
    var newVal = true;
    if (isPressed) {
      newVal = false;
    }
    else {
      newVal = true;
    }

    setState(() {
      isPressed = newVal;
    });

    updateFav();
  }

  void updateFav() async {
    var response;
    if (isPressed)
      response = await http.get(Uri.encodeFull(
          url + 'addFavorite?park=${park["coords"]}&name=${user.name}'));
    else
      response = await http.get(Uri.encodeFull(
          url + 'removeFavorite?park=${park["coords"]}&name=${user.name}'));
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
              new Image(image:AssetImage('assets/images/${park['image']}')),
              //SizedBox(height: 20),
              new Row(
                children: <Widget>[
                  new IconButton(icon: Icon(isPressed ? Icons.favorite: Icons.favorite_border), onPressed:()=> _pressed()),
                  new Text('\n ${park['location']}')
                ],
              ),
              (park["public"]=="false")?ButtonTheme.bar(
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
              ):new Container(),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profile(user))
              );
            }),
        title: Text('${park['name']}'),
      ),
      body: new SingleChildScrollView(
        //padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            new Divider(),
            ListTile(
              title: new Text('Total Lugares: ${park['lugares_max']}'),
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
            (park["public"]=="false")?_getPriceTable():new Container(padding:EdgeInsets.only(bottom:20),child:new Text("Parque Grátis",textAlign: TextAlign.left)),
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

  Widget _getPriceTable() {
    return new Column(
      children: _getDays(),
    );
  }

  List<Widget> _getDays() {
    List<Widget> days=[];
    var keys=park["pricetable"].keys.toList();
    for (var i=0;i<keys.length;i++) {
      days.add(
        new Column(
          children: _getTimes(keys[i],park["pricetable"][keys[i]])
        )
      );
    }
    return days;
  }

  List<Widget> _getTimes(String k, Map v) {
    List<Widget> times=[];
    var keys=v.keys.toList();
    for (var i=0;i<keys.length;i++) {
      times.add(
        new Text(k,textAlign: TextAlign.left),
      );
      times.add(
        new ListTile(
          subtitle: Text(keys[i],textAlign: TextAlign.left),
          trailing: Text('\n${v[keys[i]]}'),
        ),
      );
    };
    return times;
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
