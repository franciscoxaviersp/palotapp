import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'utils.dart';
import 'soon.dart';
import 'parqueUA.dart';
import 'parqueHospital.dart';
import 'parqueMusica.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user): super();

  @override
  HomePageState createState() => HomePageState(user);
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  User user;

  HomePageState(this.user): super();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: Text("ParkingALot"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Soon()),
                );
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildContainer(),
        ],
      ),
    );
  }



  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "assets/images/hospital.JPG",
                  40.634523,  -8.656944,"Estacionamento Centro Hospitalar Baixo Vouga"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                   "assets/images/ua.JPG",
                  40.630931, -8.655511,"Parque UA"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "assets/images/conservatorio.JPG",
                  40.636420, -8.654863,"Parque Conservatório de Música"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String parkName) {
    return  GestureDetector(
      onTap: () {
        if(parkName == "Estacionamento Centro Hospitalar Baixo Vouga") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParqueHospital()),
          );
        } else if(parkName == "Parque UA"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParqueUA()),
          );
        } else if(parkName == "Parque Conservatório de Música"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParqueMusica()),
          );
        }
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(parkName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String parkName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(

              child:  Text(parkName,
                style: TextStyle(
                    color: Color(0xff455a64),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              ],
            )),

      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(40.633788, -8.655800), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          hospitalMarker,uaMarker,musicaMarker
        },
      ),
    );
  }
}

Marker hospitalMarker = Marker(
  markerId: MarkerId('hospital'),
  position: LatLng(40.634523,  -8.656944),
  infoWindow: InfoWindow(title: 'Estacionamento Centro Hospitalar Baixo Vouga'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker uaMarker = Marker(
  markerId: MarkerId('ua'),
  position: LatLng(40.630931, -8.655511),
  infoWindow: InfoWindow(title: 'Parque UA'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker musicaMarker = Marker(
  markerId: MarkerId('musica'),
  position: LatLng(40.636420, -8.654863),
  infoWindow: InfoWindow(title: 'Parque Conservatório de Música'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

