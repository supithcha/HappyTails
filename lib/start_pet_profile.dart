import 'package:flutter/material.dart';
import 'option_pet_select.dart';


class StartPetProfilePage extends StatefulWidget {
  const StartPetProfilePage({Key? key}) : super(key: key);

  @override
  _StartPetProfilePageState createState() => _StartPetProfilePageState();
}

class _StartPetProfilePageState extends State<StartPetProfilePage> {
  int _selectedIndex = 0;

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
                'EMPTY PROFILE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('images/empty_icon.png', height: 240),
            ),
            // Add text
            const Text(
              'add your pet profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
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
                        builder: (context) => const OptionPetPage()),
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
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(40, 35, 0, 76),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          items: [
            // Record
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "Record",
              activeIcon: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 160, 138),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 75, 173),
                      blurRadius: 12.0,
                      spreadRadius: 2.29,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.calendar_month_outlined),
                ),
              ),
            ),
            // Clinic
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: "Clinic",
              activeIcon: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 160, 138),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 75, 173),
                      blurRadius: 12.0,
                      spreadRadius: 2.29,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.location_on_outlined),
                ),
              ),
            ),
            // Home
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 160, 138),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 75, 173),
                      blurRadius: 12.0,
                      spreadRadius: 2.29,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.home_outlined),
                ),
              ),
            ),
            // Guide
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Guide",
              activeIcon: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 160, 138),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 75, 173),
                      blurRadius: 12.0,
                      spreadRadius: 2.29,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.book_outlined),
                ),
              ),
            ),
            // Profile
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile",
              activeIcon: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 160, 138),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 75, 173),
                      blurRadius: 12.0,
                      spreadRadius: 2.29,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.person_outline_rounded),
                ),
              ),
            ),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor: Color.fromARGB(255, 0, 74, 173),
          showUnselectedLabels: true,
          selectedItemColor: Color.fromARGB(255, 0, 74, 173),
          showSelectedLabels: false,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
        ),
      ),
    );
  }
}
