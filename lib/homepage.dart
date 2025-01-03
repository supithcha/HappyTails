import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happytails/Appointment.dart';
import 'package:happytails/login.dart';
import 'package:happytails/main.dart';
import 'package:happytails/option_pet_select.dart';
import 'package:happytails/start_pet_profile.dart';
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
  List<String> petBreed = [];
  List<String> petDOB = [];
  List<String> petGender = [];
  List<String> petImage = [];

  late DateTime now = DateTime.now();
  late String formattedDate = '${now.year}-${now.month}-${now.day}';

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchPetData();
    now = DateTime.now();
    formattedDate = '${now.year}-${now.month}-${now.day}';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomepageLoading()),
      );
      print('Redirect user to Home loading');
    }
  }

  Future<void> fetchPetData() async {
    try {
      print('Try fetch Pet Data');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Pet')
          .where('User_ID', isEqualTo: Globalvar.current_userID)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          petNames =
              snapshot.docs.map((doc) => doc['Pet_Name'] as String).toList();
          print('petNames: $petNames');
          print('pet length = ');
          print(petNames.length);
          petIDs = snapshot.docs.map((doc) => doc['Pet_ID'] as String).toList();
          petWeights =
              snapshot.docs.map((doc) => doc['Pet_Weight'] as String).toList();
          petBreed =
              snapshot.docs.map((doc) => doc['Pet_Breed'] as String).toList();
          petDOB =
              snapshot.docs.map((doc) => doc['Pet_DOB'] as String).toList();
          petGender =
              snapshot.docs.map((doc) => doc['Pet_Gender'] as String).toList();
          petImage =
              snapshot.docs.map((doc) => doc['Pet_Image'] as String).toList();
        });
      } else {
        // petNames.length = 0;
        print(petNames);
        print(petNames.length);
        print('No pet data found');
      }
    } catch (e) {
      print('Failed to fetch pet data: $e');
    }
  }

  Widget _coloredBox(Color color, IconData iconData, String text) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(iconData, color: Colors.white),
      ),
    );
  }

  Widget _bigcoloredBox(Color color, String text0, String text1, String text2) {
    return Container(
      
      width: 165,
      height: 160, // Increased height to accommodate the button and extra text
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Text(
            text0,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          // SizedBox(height: 8),
          Text(
            text1,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // SizedBox(height: 8),
          Text(
            text2,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentAll(),
                              ),
                            );
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Colors.grey),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: Text(
              'View more',
              style: TextStyle(color: Color.fromARGB(255, 62, 62, 62), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _PetDetails(String? petimg, String? petname, String? petbreed,
      String? petgender, String? dob, String? weight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(
            width: 150, // Adjust the width of the image container as needed
            height: 120, // Adjust the height of the image container as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(petimg ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15), // Add spacing between the text and the image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$petname', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Type: $petbreed'),
                Text('Gender: $petgender'),
                Text('Date of Birth: $dob'),
                Text('Weight: $weight'),
              ],
            ),
          ),
        ],
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
                            fontSize: 16,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 225,
              child: Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            petNames.isNotEmpty
                                ? "Your Pet: ${petNames[0]}"
                                : 'Loading...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'See all',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartPetProfilePage(),
                                ),
                              );
                            },
                            child: _coloredBox(
                              const Color.fromARGB(255, 239, 93, 168),
                              Icons.add,
                              'Add Pet',
                            ),
                          ),
                          // Check if the petNames is not empty
                          if (petNames.isNotEmpty)
                            Padding(
                              padding:
                                  petNames.length == 1 && petNames.isNotEmpty
                                      ? EdgeInsets.only(left: 12.0, right: 8.0)
                                      : EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Center(
                                child: _coloredBox(
                                  Color.fromARGB(255, 150, 221, 220),
                                  Icons.pets,
                                  '${petNames[0]}',
                                ),
                              ),
                            ),

                          // Check if there are more than 1 element in petNames
                          if (petNames.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Center(
                                child: _coloredBox(
                                  const Color.fromARGB(255, 240, 158, 84),
                                  Icons.pets,
                                  '${petNames.length > 1 ? petNames[1] : ''}', // Check if index 1 exists
                                ),
                              ),
                            ),
                          // Check if there are more than 2 elements in petNames
                          if (petNames.length > 2)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Center(
                                child: _coloredBox(
                                  const Color.fromARGB(255, 175, 220, 147),
                                  Icons.pets,
                                  '${petNames.length > 2 ? petNames[2] : ''}', // Check if index 2 exists
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Add Pet',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: 25),
                          if (petNames.isNotEmpty)
                            Padding(
                              padding:
                                  petNames.length == 1
                                      ? EdgeInsets.only(left: 0, right: 15.0)
                                      : EdgeInsets.only(left: 0, right: 0),
                              child: Center(
                                child: Text(
                                  petNames[0] ??
                                      '...', // Use null-aware operator to handle null values
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),

                          SizedBox(width: 20),
                          if (petNames.length > 1)
                            Padding(
                              padding: EdgeInsets.only(left: 0, right: 5.0),
                              child: Center(
                                child: Text(
                                  petNames.length > 1
                                      ? petNames[1] ?? '...'
                                      : '...',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          SizedBox(width: 30),
                          //     // Check if there are more than two elements
                          if (petNames.length > 2)
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Center(
                                child: Text(
                                  petNames.length > 2
                                      ? petNames[2] ?? '...'
                                      : '...',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 25.0, right: 25.0, bottom: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Plans',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // if (petNames.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentAll(),
                              ),
                            );
                          // }
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.grey),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'See all',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bigcoloredBox(Color.fromARGB(255, 206, 243, 196),
                          formattedDate, 'Vaccination', 'Vaccination Details'),
                      _bigcoloredBox(
                          Color.fromARGB(255, 206, 194, 242),
                          formattedDate,
                          'Medical Examination',
                          'Medical Details'),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 25.0, right: 25.0, bottom: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pet Details',
                        style: TextStyle(
                          // TextStyle for the text
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OptionPetPage(),
                              ),
                            );
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.grey),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        child: Icon(Icons.edit, color: Colors.grey, size: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  if (petNames.length == 0)
                      _PetDetails('https://i.pinimg.com/474x/a2/87/72/a287720d28f7e8e91bfe6514dd18ad0b.jpg',
                      'Waiting for your pet','-','-','-','-',),
                  if (petNames.isNotEmpty)
                    for (int i = 0; i < petNames.length; i++)
                      _PetDetails(
                        petImage.length > i ? petImage[i] ?? 'null' : 'null',
                        petNames.length > i ? petNames[i] ?? 'null' : 'null',
                        petBreed.length > i ? petBreed[i] ?? 'null' : 'null',
                        petGender.length > i ? petGender[i] ?? 'null' : 'null',
                        petDOB.length > i ? petDOB[i] ?? 'null' : 'null',
                        petWeights.length > i
                            ? petWeights[i] ?? 'null'
                            : 'null',
                      ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
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
