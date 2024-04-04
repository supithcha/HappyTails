// import 'package:google_maps_flutter/google_maps_flutter.dart'; //flutter pub add google_maps_flutter

// Future<bool> requestLocationPermission() async {
//   Location location = Location();
//   PermissionStatus permissionStatus = await location.hasPermission();
//   if (permissionStatus == PermissionStatus.denied) {
//     permissionStatus = await location.requestPermission();
//   }
//   return permissionStatus == PermissionStatus.granted;
// }

// Future<LocationData?> getCurrentLocation() async {
//   Location location = Location();
//   bool hasPermission = await requestLocationPermission();
//   if (hasPermission) {
//     return await location.getLocation();
//   } else {
//     return null;
//   }
// }

// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({Key? key}) : super(key: key);

//   @override
//   _GoogleMapPageState createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   final Map<String, Marker> _markers = {};
//   int _selectedIndex = 0;

//   LocationData? currentLocation;
//   GoogleMapController? mapController;

//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentLocation();
//   }

//   // Load current location
//   void _loadCurrentLocation() async {
//     currentLocation = await getCurrentLocation();

//     if (currentLocation != null) {
//       setState(() {
//         _markers.clear();
//         _markers["currentLocation"] = Marker(
//           markerId: MarkerId("currentLocation"),
//           position: LatLng(
//             currentLocation!.latitude!,
//             currentLocation!.longitude!,
//           ),
//           infoWindow: InfoWindow(
//             title: "Your Location",
//             snippet: "Current location",
//           ),
//         );
//       });
//     }
//   }
//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   currentLocation!.latitude!,
//                   currentLocation!.longitude!,
//                 ),
//                 // target: _center,
//                 zoom: 14,
//               ),
//               markers: Set<Marker>.of(_markers.values),
//             ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:latlng/latlng.dart';
import 'package:osm_flutter_hooks/osm_flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// class MapClinicPage extends StatefulWidget {
//   MapClinicPage({Key? key}) : super(key: key);

//   @override
//   _MapClinicPageState createState() => _MapClinicPageState();
// }

// class _MapClinicPageState extends State<MapClinicPage> {
//   int _selectedIndex = 0;
//   final List<String> pages = [
//     RoutePaths.record,
//     RoutePaths.clinic,
//     RoutePaths.home,
//     RoutePaths.guide,
//     RoutePaths.profile,
//   ];

//   MapController controller = MapController(
//     initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//     areaLimit: BoundingBox(
//       east: 10.4922941,
//       north: 47.8084648,
//       south: 45.817995,
//       west: 5.9559113,
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: OSMFlutter(
//         controller: controller,
//         osmOption: OSMOption(
//           userTrackingOption: UserTrackingOption(
//             enableTracking: true,
//             unFollowUser: false,
//           ),
//           zoomOption: ZoomOption(
//             initZoom: 8,
//             minZoomLevel: 3,
//             maxZoomLevel: 19,
//             stepZoom: 1.0,
//           ),
//           userLocationMarker: UserLocationMaker(
//             personMarker: MarkerIcon(
//               icon: Icon(
//                 Icons.location_history_rounded,
//                 color: Colors.red,
//                 size: 48,
//               ),
//             ),
//             directionArrowMarker: MarkerIcon(
//               icon: Icon(
//                 Icons.double_arrow,
//                 size: 48,
//               ),
//             ),
//           ),
//           roadConfiguration: RoadOption(
//             roadColor: Colors.yellowAccent,
//           ),
//           markerOption: MarkerOption(
//             defaultMarker: MarkerIcon(
//               icon: Icon(
//                 Icons.person_pin_circle,
//                 color: Colors.blue,
//                 size: 56,
//               ),
//             ),
//             markerType: MarkerType.texture,
//             markerSize: 64,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           // Use the navigator to navigate to the selected page
//           Navigator.pushNamed(context, pages[index]);
//         },
//         pages: pages,
//       ),
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Clinic Nearby'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: new LatLng(13.801770, 100.321121),
        initialZoom: 12,
        interactionOptions:
            const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(markers: [
          // iVET Pet Hospital West Center Branch
          Marker(
              point: new LatLng(13.746950, 100.276620),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  // Show the location name and address when the marker is tapped
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5.0,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Location Name: iVET Pet Hospital West Center Branch',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 40 31-32 Borommaratchachonnani Rd, Bang Krathuek, Sam Phran District, Nakhon Pathom 73210',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.location_pin,
                    size: 60,
                    color: Colors.red,
                  ))),
          // Salaya Home Animal Hospital
          Marker(
              point: new LatLng(13.801770, 100.321120),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )),
          // โรงพยาบาลสัตว์ศวารักษ์
          Marker(
              point: new LatLng(13.793500, 100.327960),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )),
          // Prasuarthon Small Animal Hospital
          Marker(
              point: new LatLng(13.798151, 100.3177939),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )),
          // พุทธมณฑลรักษาสัตว์
          Marker(
              point: new LatLng(13.7873157, 100.333596713),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )),
          // Halmeoni Pet Hospital
          Marker(
              point: new LatLng(13.7963186, 100.3289282),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )),
        ])
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
// class SimpleOSM extends HookWidget {
//   const SimpleOSM({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = useMapController(
//       userTrackingOption: const UserTrackingOption(
//         enableTracking: true,
//         unFollowUser: true,
//       ),
//     );
//     useMapIsReady(
//       controller: controller,
//       mapIsReady: () async {
//         await controller.setZoom(zoomLevel: 15);
//       },
//     );
//     useMapListener(
//         controller: controller,
//         onSingleTap: (p) async {
//           await controller.addMarker(p);
//         });
//     return OSMFlutter(
//       controller: controller,
//       initZoom: 10,
//       markerOption: MarkerOption(
//         defaultMarker: const MarkerIcon(
//           icon: Icon(
//             Icons.person_pin_circle,
//             color: Colors.blue,
//             size: 56,
//           ),
//         ),
//       ),
//       userLocationMarker: UserLocationMaker(
//         personMarker: const MarkerIcon(
//           icon: Icon(
//             Icons.person,
//             size: 48,
//             color: Colors.red,
//           ),
//         ),
//         directionArrowMarker: const MarkerIcon(
//           icon: Icon(Icons.person),
//         ),
//       ), osmOption: null,
//     );
//   }
// }
