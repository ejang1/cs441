import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  MapScreen(this.myloclat, this.myloclong);
  double myloclat;
  double myloclong;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;

  Location myloc = new Location();
  Location target = new Location();

  Set<Circle> targetcircle = Set.from([
      Circle(
        circleId: CircleId("target"),
        center: LatLng(42.0904, -75.9693),
        radius: 0.5,
        fillColor: Colors.red,
        strokeColor: Colors.red,
      )
  ]);

  void _onMapCreated(GoogleMapController controller){
    googleMapController = controller;
    myloc.onLocationChanged.listen((l){
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude!,l.longitude!), zoom: 17,
        ),
      ));
    }
    );
    target.onLocationChanged.listen((event) {
      targetcircle = Set.from([Circle(
        circleId: CircleId("target"),
        center: LatLng(event.latitude!, event.longitude!),
        radius: 0.5,
        fillColor: Colors.red,
        strokeColor: Colors.red,
      )]);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Demo'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.myloclat, widget.myloclong),
              zoom: 17.0,
            ),
            //indoorViewEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            circles: targetcircle,
          ),
          Positioned(
            bottom: 50,
            left: 80,
            child: MaterialButton(
                child: Text("temp"),
                color: Colors.red,
                onPressed: (){}),
          ),
          Positioned(
            bottom: 50,
            right: 80,
            child: MaterialButton(
                child: Text('temp2'),
                color: Colors.blue,
                onPressed: (){}),
          )
        ],
      ),
    );
  }
}