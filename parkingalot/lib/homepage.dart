import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'utils.dart';
import 'package:parkingalot/parqueHospital.dart';
import 'package:parkingalot/profile.dart';


import 'package:location/location.dart';
import 'package:http/http.dart' as http;


//final String url = "http://217.129.242.51:5000/";
final String url = "http://192.168.43.60:5000/";
var currentLat;
var currentLong;
Map parks = null;
class HomePage extends StatefulWidget {
  final User user;
  bool close;

  HomePage(this.user,this.close): super();

  @override
  HomePageState createState() => HomePageState(user,close);
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  final User user;
  final bool close;

  HomePageState(this.user,this.close): super();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;

  @override
  Widget build(BuildContext context) {
    _getUserLocation();
    _getParks(close);
    //0bool _isLoading = false;

    void _asyncAction() async {

      await _getUserLocation();
      await _getParks(close);
    }
    _asyncAction();

    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: Text("ParkingALot"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(user,true)),
                );
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.userCircle, color: Colors.white),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(user)),
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
          children: containerChildren(),
        ),
      ),
    );
  }
  List<Widget> containerChildren(){
    List<Widget> widgets = new List<Widget>();
    if (parks != null){

      parks.forEach((key,value){
        widgets.add(new SizedBox(width: 10.0));
        String image= "assets/images/"+value['image'];
        widgets.add(new Padding( padding: const EdgeInsets.all(8.0), child: _boxes(image, key,value),
        ));
      });
    }
    return widgets;
  }

  Widget _boxes(String _image,String coordinates,Map park){

    return  GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParqueHospital(park)),
          );
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
                      child: myDetailsContainer1(park['name']),
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

  _getUserLocation() async{
    var currentLocation;
    var location = new Location();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (e) {
      currentLocation = null;
    }
    currentLat=currentLocation.latitude;
    currentLong=currentLocation.longitude;
    var tuple = [currentLocation.latitude,currentLocation.longitude];
    return tuple;
  }
  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(40.634248, -8.656225), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: markers(),
      ),
    );
  }
  Set<Marker> markers(){

    if (parks != null) {
      Set<Marker> markers = Set<Marker>();
      int i = 0;
      parks.forEach((key, value) {
        var coordinates = key.split(" ");
        Marker m = Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(
              double.parse(coordinates[0]), double.parse(coordinates[1])),
          infoWindow: InfoWindow(title: value['name']),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
        );
        markers.add(m);
        i++;
      });
      return markers;
    }
    return null;
  }

}
_getParks(bool close) {

  String temp;
  if (close!=null) {
    if(!close){
      temp = url + 'allParksInfo';
    }else {
      temp = url + 'allParksInfo?park=$currentLat%$currentLong';
    }
  }else{
    temp = url + 'allParksInfo';
  }

  Future<String> makeRequest() async {
    print(close);
    var response = await http.get(Uri.encodeFull(temp));
    if (response.statusCode >= 200 && response.statusCode <= 400) {
      parks = jsonDecode(response.body);
    }
    else {
      throw new Exception("Error while fetching data");
    }
  }
  makeRequest();
}



