import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';
import 'global_variables.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Homepage()); // No need to pass the username here
}

class Homepage extends StatefulWidget {
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
    int? userID = current_userID; // Fetch current user ID from global variables
    if (userID != null) {
      //String? fullname = await getUsernameByID(userID.toString());
      if (fullname != null) {
        setState(() {
          userFullname = fullname; // Update the state variable
        });
        print('Fetched user information: $userFullname');
      } else {
        print('User not found');
      }
    } else {
      print('User ID not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Tails',
      theme: ThemeData(
        fontFamily: 'Futura',
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            userFullname != null ? 'Hello, $userFullname' : 'Loading...',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
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
        body: Container(), // Placeholder for the body
      ),
    );
  }
}
