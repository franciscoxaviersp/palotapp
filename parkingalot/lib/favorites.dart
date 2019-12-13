import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingalot/signin.dart';
import 'package:parkingalot/profile.dart';
import 'package:parkingalot/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:parkingalot/parque.dart';
import 'utils.dart';


String url = 'http://192.168.43.60:5000/';
//String url = 'http://10.0.2.2:5000/';
class Favorites extends StatefulWidget{

  User user;
  final bool isReg;
  Map parks;
  Favorites(this.user,this.isReg,this.parks):super();
  @override
  FavoritesState createState() => FavoritesState(user,isReg,parks);
}
class FavoritesState extends State<Favorites> {
  final User user;
  bool isReg;
  Map parks;
  Map park;
  FavoritesState(this.user,this.isReg,this.parks):super();

  initState(){
    super.initState();
  }
   _getPark(String s) async {
        String info = url+'parkInfo?park=$s';
       _makeRequest() async {
       var response = await http.get(Uri.encodeFull(info));
       if (response.statusCode >= 200 && response.statusCode <= 400) {
         park = jsonDecode(response.body);
       }
     }
     await _makeRequest();
   }
  _pressed(String s) async{

    await _getPark(s);
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new Parque(park, user)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(parks.values);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Parques Favoritos'),

      ),
      body: SingleChildScrollView(
           child:new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               SizedBox(
                 height: 500,
                 width: 500,
                 child:
                  new ListView.builder(
                    itemCount: parks.keys.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          title: Text(parks.values.toList()[index]),
                          trailing: isReg ? IconButton(
                            icon: Icon((Icons.arrow_forward_ios)),
                            onPressed:()=> _pressed(parks.keys.toList()[index]),
                          ): Text(''),
                      );
                      },
                ),
             ),
        ],

          ),
      ),

    );


  }

}
