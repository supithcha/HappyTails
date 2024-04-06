import 'package:flutter/material.dart';
import 'start_pet_profile.dart';
import 'global_variables.dart'; 

class Welcome extends StatelessWidget {
  final String? username;

  const Welcome({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 253, 206, 179), Colors.white],
                ),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Welcome to',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/logo/full_logo_blue.png',
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello, $username.', // Display dynamic username here
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Let's get start the application to take care your partner!",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.8, // 80% of the screen width
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartPetProfilePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 74, 173),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Join',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

