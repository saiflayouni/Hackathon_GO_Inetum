import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
@override
Widget build(BuildContext context){
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleMapController ;    


  const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  return Scaffold(
    body: Stack(children: [
      GoogleMap(mapType: MapType.normal,
      myLocationButtonEnabled: true,
      initialCameraPosition:_kGooglePlex ,
      onMapCreated: (GoogleMapController mapController){
          _controller.complete(mapController);
          newGoogleMapController = mapController ;
      },)
    ],),
  )
}
}
