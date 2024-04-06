import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'global_variables.dart' as Globalvar;
import 'package:happytails/route_paths.dart';
import 'package:happytails/petprofile.dart';
import 'package:happytails/bottom_nav_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userFullname;
  List<String> petNames = [];
  List<String> petIDs = [];
  List<String> petWeights = [];

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchPetData();
  }

  Future<void> fetchUsername() async {
    String? username =
        await Globalvar.getUsernameByID(Globalvar.current_userID);
    if (username != null && username.isNotEmpty) {
      setState(() {
        userFullname = username;
      });
      print('Fetched user information: $userFullname');
    } else {
      print('Username not found');
    }
  }

  Future<void> fetchPetData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Pet')
          .where('User_ID', isEqualTo: Globalvar.current_userID)
          .get();
      setState(() {
        petNames =
            snapshot.docs.map((doc) => doc['Pet_Name'] as String).toList();
        print(petNames);
        petIDs = snapshot.docs.map((doc) => doc['Pet_ID'] as String).toList();
        petWeights =
            snapshot.docs.map((doc) => doc['Pet_Weight'] as String).toList();
      });
    } catch (e) {
      print('Failed to fetch pet data: $e');
    }
  }

  Widget _coloredBox(String petGender, Color color, IconData iconData) {
    if (petGender != '') {
      if (petGender == 'Female') {
        color = const Color.fromARGB(255, 239, 93, 168);
        iconData = Icons.female;
      } else if (petGender == 'Male') {
        color = const Color.fromARGB(255, 0, 74, 173);
        iconData = Icons.male;
      }
    } else {}

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(iconData, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  'assets/logo/logo-white.png',
                  width: 60,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userFullname != null
                          ? 'Hello, $userFullname'
                          : 'Loading...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'How is your pet\'s health today?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  _shownotitext(context);
                },
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 225,
            child: Card(
              margin: EdgeInsets.all(32),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          //petMedhis ?? 'Loading...', // Text content
                          petNames.isNotEmpty
                              ? "Your Pets: ${petNames[0]}"
                              : 'Loading...',
                          style: TextStyle(
                            // TextStyle for the text
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the pet profile page
                            // Assuming petName is the first pet name
                            if (petNames.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PetProfilePage(petid: petIDs.first),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Colors.grey),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Details',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            5), // Add some space between the text and the row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _coloredBox('', Colors.pink, Icons.female),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 174, 175, 247),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              petWeights.isNotEmpty
                                  ? petWeights.first
                                  : '', // Assuming petWeight is the first weight
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        _coloredBox(
                            '',
                            const Color.fromARGB(255, 160, 227, 226),
                            Icons.check),
                        _coloredBox('', const Color.fromARGB(255, 240, 158, 84),
                            Icons.favorite),
                        _coloredBox(
                            '',
                            const Color.fromARGB(255, 175, 220, 147),
                            Icons.menu_book),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Vaccine',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Health',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Record',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: Text(
                  "Appointment",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //SizedBox(width: 220), // Add space between the text and button
              TextButton(
                onPressed: () {
                  // Navigate to the appointments
                  // Assuming petName is the first pet name
                  if (petNames.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PetProfilePage(petid: petIDs.first),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.grey),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 2,
      ),
    );
  }
}

void _shownotitext(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        title: Text('Notification'),
        content: Container(
          child: Text(
            'Empty notification',
            style: TextStyle(fontSize: 16.0), // Adjust the font size here
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 74, 173),
              ),
            ),
          ),
        ],
      );
    },
  );
}
