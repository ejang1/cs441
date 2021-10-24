import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  MapScreen({required this.myloclat, required this.myloclong});
  double myloclat;
  double myloclong;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;


  void _onMapCreated(GoogleMapController controller){
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Demo'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.myloclat, widget.myloclong),
          zoom: 15.0,
        ),
      ),
    );
  }
}