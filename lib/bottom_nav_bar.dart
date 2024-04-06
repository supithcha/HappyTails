import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:happytails/clinic_page.dart';
import 'package:happytails/homepage.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/start_pet_appt.dart';
import 'package:happytails/start_pet_profile.dart';
import 'package:happytails/tips_and_tricks.dart';
// import 'package:happytails/route_paths.dart';
// ยังให้สีส้มกลมๆเลื่อนตามindex of nav ไม่ได้
// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;
//   final List<String> pages;

//   const BottomNavBar({
//     required this.selectedIndex,
//     required this.onItemTapped,
//     required this.pages,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

// return Container(
//   decoration: const BoxDecoration(
//     borderRadius: BorderRadius.only(
//       topRight: Radius.circular(30),
//       topLeft: Radius.circular(30),
//     ),
//     boxShadow: <BoxShadow>[
//       BoxShadow(
//         color: Color.fromARGB(40, 35, 0, 76),
//         blurRadius: 10,
//       ),
//     ],
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.only(
//       topRight: Radius.circular(30),
//       topLeft: Radius.circular(30),
//     ),
//     child: BottomNavigationBar(
//       items: [
//         // Record
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_month_outlined),
//           label: "Record",
//           activeIcon: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 160, 138),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(50, 0, 75, 173),
//                   blurRadius: 12.0,
//                   spreadRadius: 2.29,
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.calendar_month_outlined),
//             ),
//           ),
//         ),
//         // Clinic
//         BottomNavigationBarItem(
//           icon: Icon(Icons.location_on_outlined),
//           label: "Clinic",
//           activeIcon: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 160, 138),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(50, 0, 75, 173),
//                   blurRadius: 12.0,
//                   spreadRadius: 2.29,
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.location_on_outlined),
//             ),
//           ),
//         ),
//         // Home
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: "Home",
//           activeIcon: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 160, 138),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(50, 0, 75, 173),
//                   blurRadius: 12.0,
//                   spreadRadius: 2.29,
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.home_outlined),
//             ),
//           ),
//         ),
//         // Guide
//         BottomNavigationBarItem(
//           icon: Icon(Icons.book_outlined),
//           label: "Guide",
//           activeIcon: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 160, 138),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(50, 0, 75, 173),
//                   blurRadius: 12.0,
//                   spreadRadius: 2.29,
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.book_outlined),
//             ),
//           ),
//         ),
//         // Profile
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_outline_rounded),
//           label: "Profile",
//           activeIcon: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 160, 138),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(50, 0, 75, 173),
//                   blurRadius: 12.0,
//                   spreadRadius: 2.29,
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.person_outline_rounded),
//             ),
//           ),
//         ),
//       ],
//       currentIndex: selectedIndex,
//       unselectedItemColor: Color.fromARGB(255, 0, 74, 173),
//       showUnselectedLabels: true,
//       selectedItemColor: Color.fromARGB(255, 0, 74, 173),
//       showSelectedLabels: false,
//       onTap: onItemTapped,

//       type: BottomNavigationBarType.fixed,
//       unselectedFontSize: 14,
//     ),
//   ),
// );
class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({
    required this.initialIndex,
    // required this.pages,
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int selectedIndex;
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
    selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.of(context).pushReplacementNamed(pages[index]);
      print(pages[index]);
    });
  }

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
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
        ),
      ),
    );
  }
}

