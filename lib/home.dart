// Start Page
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'option_pet_select.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomepageLoading(),
    );
  }
}

class HomepageLoading extends StatelessWidget {
  const HomepageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => Welcome(),
          builder: (context) => Login(),
        ),
      );
    });

    return Scaffold(
      body: Container(
        color: Color(0xff004aad),
        child: Center(
          child: Image.asset(
            'assets/logo/full_logo_white.png',
            height: 300,
          ),
        ),
      ),
    );
  }
}


