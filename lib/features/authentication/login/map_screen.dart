// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget {
  // const MapScreen({super.key});



  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  CameraPosition? currentCameraPosition;
  LatLng? currentPosition;
  Set<Marker> markerSet = {};
  Marker? marker;

  LatLng? selectedLocation;

  // Set<Marker>? markers;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? newgooglemapcontroller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


 bool isMapReady = false;
  void setMap(bool value) {
    setState(() {
      isMapReady = value;
    });
  }

  void setMarker(LatLng location) {
    marker = Marker(
      markerId: MarkerId('dropmarker'),
      position: location,
    );

    setState(() {
      markerSet.add(marker as Marker);
      selectedLocation = location;
    });
    moveCamera(location);
  }

  void moveCamera(LatLng position) {
    newgooglemapcontroller!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: position, zoom: 17.999),
    ));
  }

  

   

  



/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
/// 
/// 
/// 

void getCurrentLocation()  async {
  //  setCameraPostionToMyCurrentLocation();
  newgooglemapcontroller!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentPosition as LatLng, zoom: 17.999),
    ));
  }


   void setCameraPostionToMyCurrentLocation() async {




   var permitted = await locationPermision();
   print('____________');
   print(permitted);

   if(permitted){
     Position response = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);     
     setState(() {
      currentPosition = LatLng(response.latitude, response.longitude);
     currentCameraPosition = CameraPosition(target:currentPosition as LatLng , zoom: 16.999, tilt: 40, bearing: -1000);   
     isMapReady = true;   
     });
      // print('permitted');
      // print('--------------------------------');
      // print(currentCameraPosition);



   }else{
      print(' not permitted');

   }
    // if (permitted) {
    //     Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //     LatLng position = LatLng(currentPosition.latitude, currentPosition.longitude);
    //     CameraPosition cameraPosition = CameraPosition( target: position as LatLng,);
    //     newgooglemapcontroller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //     setMap(permitted);
    // }else{
    //   print('not permitted');
    // }
  }

  
Future<bool> locationPermision() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  // Position currentpostion = await  Geolocator.getCurrentPosition();
  // print('--------------------------------');
  // print(currentpostion);
  // print('--------------------------------');
  return serviceEnabled;
}

  @override
  void initState() {
    // TODO: implement initState
      // getCurrentLocation();
        setCameraPostionToMyCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
      if (newgooglemapcontroller != null) {
      newgooglemapcontroller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){
            if(selectedLocation != null) {
            // widget.setLocation!(selectedLocation); 

            Get.back(result: selectedLocation);

            }else{
                          Get.back();
            }
          }, child: Icon(Icons.save))
        ],
      ),
      body: isMapReady   == false  ? Center(child: const CircularProgressIndicator(),) : GoogleMap(
        onTap: (location) => setMarker(location),
        markers: markerSet,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller)  async {
          _controller.complete(controller);
             newgooglemapcontroller = controller;
             getCurrentLocation();
            
        },
      ) ,
     
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
