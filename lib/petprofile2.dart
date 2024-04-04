import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happytails/createpetprofile.dart';
import 'dart:convert';

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
      });
      print('Fetched pet information: $petImage, $petName, $petBreed, $petDOB');
    } else {
      print('Document not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pet Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: petImage != null
                  ? DecorationImage(
                      image: MemoryImage(base64Decode(petImage!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),

          // White Area with Pet Information
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _coloredBox(
                        const Color.fromARGB(255, 239, 93, 168), Icons.pets),
                    _coloredBox(const Color.fromARGB(255, 174, 175, 247),
                        Icons.favorite),
                    _coloredBox(const Color.fromARGB(255, 160, 227, 226),
                        Icons.favorite),
                    _coloredBox(const Color.fromARGB(255, 240, 158, 84),
                        Icons.videogame_asset),
                    _coloredBox(const Color.fromARGB(255, 175, 220, 147),
                        Icons.sports_basketball),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coloredBox(Color color, IconData icon) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
