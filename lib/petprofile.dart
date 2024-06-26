import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:happytails/createpetprofile.dart';
import 'dart:convert';

import 'package:happytails/route_paths.dart';

class PetProfilePage extends StatefulWidget {
  final String petid;

  const PetProfilePage({Key? key, required this.petid}) : super(key: key);

  @override
  _PetProfilePageState createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  String? petImage;
  late String petName = '';
  late String petBreed = '';
  late String petDOB = '';
  late String petMedhis = '';
  late String petGender = '';
  late String petWeight = '';

  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.petid != null) {
      fetchPetInformationById(widget.petid!);
    } else {
      print('Error: petid is null');
    }
  }

  Future<void> fetchPetInformationById(String petId) async {
    print('pet id receive from create pet profile = $petId');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Pet')
        .where('Pet_ID', isEqualTo: petId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot petSnapshot = querySnapshot.docs.first;
      setState(() {
        petImage = petSnapshot['Pet_Image'];
        petName = petSnapshot['Pet_Name'];
        petBreed = petSnapshot['Pet_Breed'];
        petDOB = petSnapshot['Pet_DOB'];
        petMedhis = petSnapshot['Pet_Med_History'];
        petGender = petSnapshot['Pet_Gender'];
        petWeight = petSnapshot['Pet_Weight'];
      });
      print('Fetched pet information: $petName');
      print('Pet_Name: $petName');
      print('Pet_Image: $petImage');
    } else {
      print('Document not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pet Image
            Stack(
              children: [
                // Pet Image

                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: petImage != null
                        ? DecorationImage(
                            image: NetworkImage(petImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),

                // Notification Icon
                Positioned(
                  top: 20,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    color: Colors.white,
                    onPressed: () {
                      _shownotitext(context);
                    },
                  ),
                ),
              ],
            ),
            // White Area with Pet Information
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    petName ?? 'Loading...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        petBreed ?? 'Loading...',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        'Birthday: ${petDOB != null ? petDOB.toString() : 'Loading...'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _coloredBox(petGender, Colors.pink, Icons.female),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 174, 175, 247),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            petWeight,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      // _coloredBox('', const Color.fromARGB(255, 174, 175, 247),
                      //     Icons.numbers),
                      _coloredBox('', const Color.fromARGB(255, 160, 227, 226),
                          Icons.check),
                      _coloredBox('', const Color.fromARGB(255, 240, 158, 84),
                          Icons.favorite),
                      _coloredBox('', const Color.fromARGB(255, 175, 220, 147),
                          Icons.menu_book),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Weight',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Vaccine',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Health',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Record',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical history',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 188, 188)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
          minHeight: 150,
          minWidth: 350, // Set a minimum height for the container
        ),
        
                          child: Text(
                            petMedhis ?? 'Loading...',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow
                                .clip, // Or TextOverflow.fade to fade the text
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 2, // Initial selected index
        // pages: pages
      ),
    );
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
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(iconData, color: Colors.white),
      ),
    );
  }
}

// String _padBase64String(String input) {
//   int remainder = input.length % 4;
//   if (remainder == 0) {
//     return input;
//   } else {
//     // Add '=' padding characters to make length a multiple of four
//     return input.padRight(input.length + (4 - remainder), '=');
//   }
// }

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
