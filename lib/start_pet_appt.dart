import 'package:flutter/material.dart';
import 'package:happytails/create_appointment.dart';
import 'option_pet_select.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:happytails/route_paths.dart';


class StartPetApptPage extends StatefulWidget {
  const StartPetApptPage({Key? key}) : super(key: key);

  @override
  _StartPetApptPageState createState() => _StartPetApptPageState();
}

class _StartPetApptPageState extends State<StartPetApptPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty Profile text
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: const Text(
                'EMPTY APPOINTMENT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('assets/logo/empty_icon.png', height: 240),
            ),
            // Add text
            const Text(
              'add your pet appointment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            // Add button
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePetApptPage()),
                  );
                },
                color: const Color.fromARGB(255, 0, 74, 173),
                icon: const Icon(Icons.add_circle_rounded, size: 42.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 0, // Initial selected index
      ),
    );
  }
}
