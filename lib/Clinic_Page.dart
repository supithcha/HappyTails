import 'package:flutter/material.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_flutter_hooks/osm_flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MapClinicPage(title: 'Clinic Nearby'),
//     );
//   }
// }

class MapClinicPage extends StatefulWidget {
  const MapClinicPage({super.key, required this.title});

  final String title;

  @override
  State<MapClinicPage> createState() => _MapClinicPageState();
}

class _MapClinicPageState extends State<MapClinicPage> {
  int _selectedIndex = 0;
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content(),
      // bottomNavigationBar: BottomNavBar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: (index) {
      //      // Use the navigator to navigate to the selected page
      //     Navigator.pushNamed(context, pages[index]);
      //   },
      //     pages: pages,
      // ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 1, // Initial selected index
        // pages: pages
      ),
    );
  }

  Widget content() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: new LatLng(13.801770, 100.321121),
        initialZoom: 12.5,
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
                                  'Location Name: Salaya Home Animal Hospital',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 50 หมู่5 ถนนศาลายา - บางภาษี Salaya, Phutthamonthon District, Nakhon Pathom 73170',
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
          // โรงพยาบาลสัตว์ศวารักษ์
          Marker(
              point: new LatLng(13.793500, 100.327960),
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
                                  'Location Name: โรงพยาบาลสัตว์ศวารักษ์',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 87/11 Salaya, Phutthamonthon District, Nakhon Pathom 73170',
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
          // Prasuarthon Small Animal Hospital
          Marker(
              point: new LatLng(13.798151, 100.3177939),
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
                                  'Location Name: Prasuarthon Small Animal Hospital',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 999 Phutthamonthon Sai 4 Rd, Salaya, Phutthamonthon District, Nakhon Pathom 73170',
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
          // พุทธมณฑลรักษาสัตว์
          Marker(
              point: new LatLng(13.7873157, 100.333596713),
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
                                  'Location Name: พุทธมณฑลรักษาสัตว์',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 81, 85-86 Borommaratchachonnani Rd, Sala Thammasop, Thawi Watthana, Bangkok 10170',
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
          // Halmeoni Pet Hospital
          Marker(
              point: new LatLng(13.7963186, 100.3289282),
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
                                  'Location Name: Halmeoni Pet Hospital',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Address: 135, 560 Salaya Soi 1, Salaya, Phutthamonthon District, Nakhon Pathom 73170',
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
        ])
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );