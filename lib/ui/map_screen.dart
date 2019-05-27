import 'dart:async';
import 'package:health_app/ui/exerciseUI.dart';
import 'package:health_app/ui/wait.dart';

import 'map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  double lati;
  double long;
  MapScreen({this.lati, this.long});
  @override
  State<StatefulWidget> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  var location = new Location();
  Map<String, double> userLocation;
  GoogleMapController mapController;

  // void readlocation() {
  //   _getLocation().then((value){
  //     setState((){
  //       userLocation = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double lati = widget.lati;
    double long = widget.long;

    return Stack(
      children: <Widget>[
        GoogleMap(
          markers: {
            Marker(
                markerId: MarkerId("1"),
                position: LatLng(13.7289103, 100.7725066),
                infoWindow: InfoWindow(
                    title: "สนามกีฬา KMITL",
                    snippet:
                        "สนามกีฬา สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง")),
            Marker(
                markerId: MarkerId("2"),
                position: LatLng(13.7233973, 100.780955),
                infoWindow: InfoWindow(
                    title: "FBT Fitness Center",
                    snippet: "FBT Fitness Center")),
            Marker(
                markerId: MarkerId("3"),
                position: LatLng(13.721492, 100.781764),
                infoWindow: InfoWindow(title: "ศูนย์เยาวชนลาดกระบัง")),
            Marker(
                markerId: MarkerId("4"),
                position: LatLng(13.721254, 100.755930),
                infoWindow: InfoWindow(title: "TCP Studio Cycling Coach")),
            Marker(
                markerId: MarkerId("5"),
                position: LatLng(13.7204828, 100.7566118),
                infoWindow: InfoWindow(title: "คิ๊กคลับ มวยไทย")),
            Marker(
                markerId: MarkerId("6"),
                position: LatLng(13.7517934, 100.7955187),
                infoWindow: InfoWindow(title: "นาวส์ฟิตเนส")),
            Marker(
                markerId: MarkerId("7"),
                position: LatLng(13.7144708, 100.7947765),
                infoWindow: InfoWindow(title: "Rocker Garden")),
            Marker(
                markerId: MarkerId("8"),
                position: LatLng(13.7150429, 100.8222855),
                infoWindow: InfoWindow(
                    title: "เนโกะ ฟิตเนส ลาดกระบัง (Neko Fitness Ladkrabang)")),
            Marker(
                markerId: MarkerId("9"),
                position: LatLng(13.7439822, 100.7923872),
                infoWindow:
                    InfoWindow(title: "Pyramid Tennis Academy Futsal Field")),
            Marker(
                markerId: MarkerId("10"),
                position: LatLng(13.723213, 100.7365601),
                infoWindow: InfoWindow(title: "S Motor Sport &TOR")),
            Marker(
                markerId: MarkerId("11"),
                position: LatLng(13.6950458, 100.7297622),
                infoWindow: InfoWindow(title: "VEGA FITNESS")),
            Marker(
                markerId: MarkerId("12"),
                position: LatLng(13.7018877, 100.6859854),
                infoWindow: InfoWindow(title: "Next-G Sport and Fitness")),
            Marker(
                markerId: MarkerId("13"),
                position: LatLng(13.6942227, 100.6719608),
                infoWindow: InfoWindow(title: "DNA fitness Club สวนหลวง ร.9")),
            Marker(
                markerId: MarkerId("14"),
                position: LatLng(13.6623374, 100.6935924),
                infoWindow:
                    InfoWindow(title: "Lake View Fitness @ Blue Lagoon")),
            Marker(
                markerId: MarkerId("15"),
                position: LatLng(13.648542, 100.6819943),
                infoWindow: InfoWindow(title: "Fitness First - Mega Bangna")),
            Marker(
                markerId: MarkerId("16"),
                position: LatLng(13.6215355, 100.7561582),
                infoWindow: InfoWindow(title: "Chic Fitness")),
            Marker(
                markerId: MarkerId("17"),
                position: LatLng(14.0162361, 100.8084655),
                infoWindow: InfoWindow(title: "SD Fitness")),
            Marker(
                markerId: MarkerId("18"),
                position: LatLng(13.7751373, 100.6705992),
                infoWindow: InfoWindow(title: "Boost Fitness Bangkok")),
          },
          onMapCreated: (controller) {
            mapController = controller;
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(lati, long), zoom: 12),
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
        ),
        // Positioned(
        //   left: 30.0,
        //   bottom: 30.0,
        //   child: FloatingActionButton(
        //     mini: true,
        //     onPressed: () {

        //     },
        //     child: const Icon(Icons.my_location, size: 40.0),
        //   ),
        // ),
        Positioned(
          left: 30.0,
          bottom: 30.0,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Wait()));
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Colors.white10,
            child: const Icon(Icons.arrow_back, size: 40.0),
          ),
        ),
      ],
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}

// void near(){
//               Map<MarkerId, Marker> markerss = <MarkerId, Marker>{
//                 MarkerId selectedMarker;
//               double min_dis = 0;
//               double xxx1 = 0;
//               double yyy1 = 0;

//               for (Marker mark in markerss) {
//                 final Marker marker = markerss[mark];
//                 final LatLng current = marker.position;
//                 double xxx = current.latitude;
//                 double yyy = current.longitude;
//                 double ans = abs(sqrt(pow((lati-xxx), 2) + pow((long-yyy), 2)));

//                 if (ans<min_dis) {
//                   xxx1 = xxx;
//                   yyy1 = yyy;
//                   min_dis = ans;
//                 }
//               }
//               return LatLng(xxx1, yyy1);
// }
//               };
// }

// void getNearbyPlaces(LatLng center) async {
//     setState(() {
//       this.isLoading = true;
//       this.errorMessage = null;
//     });

//     final location = Location(lati, long);
//     final result = await _places.searchNearbyWithRadius(location, 2000);
//     var list = [""];
//     setState(() {
//       this.isLoading = false;
//       if (result.status == "OK") {
//         // this.places = result.results;
//         result.results.forEach((f) {
//           for(var a in f.types){
//             if (list.contains(a)){
//               this.places.add(f);
//             }
//             break;
//             }
//             final markerOptions = MarkerOptions(
//                 position:
//                     LatLng(f.geometry.location.lat, f.geometry.location.lng),
//                 infoWindowText:
//                     InfoWindowText("${f.name}", "${f.types?.first}"));
//             mapController.addMarker(markerOptions);
//         });
//       } else {
//         this.errorMessage = result.errorMessage;
//       }
//     });

//   }
