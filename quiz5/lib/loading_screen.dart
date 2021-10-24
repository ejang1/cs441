import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'map_screen.dart';
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = new Location();
  late double myLocationLat = 0;
  late double myLocationLong = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  void _getLocation() async{
    //check permission
    try{
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      LocationData myLocation = await location.getLocation();
      this.myLocationLat = myLocation.latitude!;
      this.myLocationLong = myLocation.longitude!;
    }catch(e){
      print(e);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return MapScreen(myloclat: myLocationLat, myloclong: myLocationLong,);
    }));

    //print(myLocationLat);
    //print(myLocationLong);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourGlass(
          color: Colors.white,
          size: 300,
        ),
      ),
    );
  }
}
