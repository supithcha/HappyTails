import 'package:flutter/material.dart';
import 'package:happytails/detailPage/details_page.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';

class Veterinary extends StatelessWidget {
  const Veterinary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Veterinary list:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
          // Add other widgets as needed
          _ProductBox(
            Date: "12 January 2024 11:00 AM",
            description: "The Pet Center",
            Petname: "Chanel",
            image: "assets/Appointment/hospital.png",
            Phone: " Tel: 1119",
            onTap: () {
              // Navigate to details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                  date: "12 January 2024 11:00 AM",
                  description: "The Pet Center",
                  petName: "Chanel",
                  phone: " Tel: 1119",
                  appointmentType: "Veterinary", // Specify the appointment type
                  address: "Address for Veterinary",
                  time: "Open: 10.00-22.00",
                  services: ["Regular check-ups", "Diagnostic", "Dental Care"],
                  image: "Appointment/PetCenter.jpg",
                ),
              ),
            );

            },
          ),
          _ProductBox(
            Date: "8 January 2023 02:00 PM",
            description: "The Pet Center",
            Petname: "Chanel",
            image: "assets/Appointment/hospital.png",
            Phone: " Tel: 1119",
            onTap: () {
              // Navigate to details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                  date: "8 January 2023 02:00 PM",
                  description: "The Pet Center",
                  petName: "Chanel",
                  phone: " Tel: 1119",
                  appointmentType: "Veterinary", // Specify the appointment type
                  address: "Address for Veterinary",
                  time: "Open: 10.00-22.00",
                  services: ["Regular check-ups", "Diagnostic", "Dental Care"],
                  image: "Appointment/PetCenter.jpg",
                ),
              ),
            );

            },
          ),
        ],
      ),
    );
  }
}

class _ProductBox extends StatelessWidget {
  _ProductBox({
    Key? key,
    this.Date,
    this.description,
    this.Petname,
    this.image,
    this.Phone,
    this.onTap,
  }) : super(key: key);

  final String? Date;
  final String? description;
  final String? Petname;
  final String? image;
  final String? Phone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    
    return Container(
      padding: EdgeInsets.fromLTRB(10, 7, 10, 1),
      height: 190,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 15),
                child: Image.asset(image!),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.access_alarm, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            Date!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.place, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            description!,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.pets, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            Petname!,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        Phone!,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 1),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 1, 2, 10),
                            child: ElevatedButton(
                              onPressed: onTap,
                              style: ElevatedButton.styleFrom(
                                
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Detail',
                                style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const BottomNavBar({
//     required this.selectedIndex,
//     required this.onItemTapped,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Color.fromARGB(40, 35, 0, 76),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//         child: BottomNavigationBar(
//           items: [
//             // Record
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: "Record",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.calendar_month_outlined),
//                 ),
//               ),
//             ),
//             // Clinic
//             BottomNavigationBarItem(
//               icon: Icon(Icons.location_on_outlined),
//               label: "Clinic",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.location_on_outlined),
//                 ),
//               ),
//             ),
//             // Home
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: "Home",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.home_outlined),
//                 ),
//               ),
//             ),
//             // Guide
//             BottomNavigationBarItem(
//               icon: Icon(Icons.book_outlined),
//               label: "Guide",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.book_outlined),
//                 ),
//               ),
//             ),
//             // Profile
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline_rounded),
//               label: "Profile",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.person_outline_rounded),
//                 ),
//               ),
//             ),
//           ],
//           currentIndex: selectedIndex,
//           unselectedItemColor: Color.fromARGB(255, 0, 74, 173),
//           showUnselectedLabels: true,
//           selectedItemColor: Color.fromARGB(255, 0, 74, 173),
//           showSelectedLabels: false,
//           onTap: onItemTapped,
//           type: BottomNavigationBarType.fixed,
//           unselectedFontSize: 14,
//         ),
//       ),
//     );
//   }
// }
