import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'global_variables.dart' as Globalvar;
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Homepage());
}

class Homepage extends StatefulWidget {
  //final String UserFullname;

  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userFullname; // Variable to store the username

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch username when the widget initializes
  }

  Future<void> fetchUsername() async {
    String? username =
        await Globalvar.getUsernameByID(Globalvar.current_userID);
    if (username != null && username.isNotEmpty) {
      setState(() {
        userFullname = username; // Update the state variable
      });
      print('Fetched user information: $userFullname');
    } else {
      print('Username not found');
    }
  }

  // Use the defined route paths
  // final List<String> pages = [
  //   RoutePaths.record,
  //   RoutePaths.clinic,
  //   RoutePaths.home,
  //   RoutePaths.guide,
  //   RoutePaths.profile,
  // ];
  // int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HappyTails',
      theme: ThemeData(
        fontFamily: 'Futura',
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
           child: AppBar(
            title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Image.asset(
                  'logo/logo-white.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userFullname != null ? 'Hello, $userFullname' : 'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'How is your pet\'s health today?',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Add  notification logic here
              },
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
                 // Colors.white,
                  Colors.indigo.shade200,
                  Colors.indigo.shade400,
                  Colors.indigo.shade700,
                  Colors.indigo.shade900,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
       
        ),
      
      ),
       body: Container(), // Placeholder for the body
        // bottomNavigationBar: BottomNavBar(
        //   selectedIndex: _selectedIndex,
        //   onItemTapped: (index) {
        //     Navigator.pushNamed(context, pages[index]);
        //   },
        //   pages: pages,
        // ),
        bottomNavigationBar: BottomNavBar(
          initialIndex: 2, // Initial selected index
          // pages: pages
        ),
      
      ),
    );
  }
}
