import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Homepage(UserFullname: 'Fayfay')); // Pass the username here
}

class Homepage extends StatefulWidget {
  final String UserFullname;

  const Homepage({Key? key, required this.UserFullname}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userFullname; // Variable to store the username

  @override
  void initState() {
    super.initState();
    fetchUsername(widget.UserFullname); // Fetch username when the widget initializes
  }

  Future<void> fetchUsername(String username) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('User_ID', isEqualTo: 6)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      setState(() {
        userFullname = userSnapshot['User_Fullname']; // Update the state variable
      });
      print('Fetched user information: $userFullname');
    } else {
      print('Document not found');
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
