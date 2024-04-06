import 'package:flutter/material.dart';
import 'package:happytails/detailPage/details_page.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';
int _selectedIndex = 0;
  // Use the defined route paths
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];
class Vaccination extends StatelessWidget {
  const Vaccination({Key? key}) : super(key: key);
  

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
                'Vaccination list:',
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
            description: "UVET Animal Hospital",
            Petname: "Chanel",
            image: "Appointment/vaccine.png",
            Phone: " Tel: 1119",
            onTap: () {
              // Navigate to details page
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                date: "12 January 2024 11:00 AM",
                description: "UVET Animal Hospital",
                petName: "Chanel",
                phone: " Tel: 062-491-9494",
                appointmentType: "Vaccination", // Specify the appointment type
                address: "Tritot City Marina, Charoen Nakhon Rd, Bang Lamphu Lang, Khlong San, Bangkok 10600",
                time: "Open: 10.00-22.00",
                services: ["Individualized Consultation and counseling vaccination services", "Vaccination and Certification", "Vaccination service prior to Pre-Post travelling abroad"],
                image: "Appointment/UVET.jpg",
                ),
              ),
            );

            },
          ),
          _ProductBox(
            Date: "8 January 2023 02:00 PM",
            description: "UVET Animal Hospital",
            Petname: "Chanel",
            image: "Appointment/vaccine.png",
            Phone: " Tel: 062-491-9494",
            onTap: () {
              // Navigate to details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                  date: "8 January 2023 02:00 PM",
                  description: "UVET Animal Hospital",
                  petName: "Chanel",
                  phone: " Tel: 062-491-9494",
                  appointmentType: "Vaccination", // Specify the appointment type
                  address: "Tritot City Marina, Charoen Nakhon Rd, Bang Lamphu Lang, Khlong San, Bangkok 10600",
                  time: "Open: 10.00-22.00",
                  services: ["Individualized Consultation and counseling vaccination services", "Vaccination and Certification", "Vaccination service prior to Pre-Post travelling abroad"],
                  image: "Appointment/UVET.jpg",
                ),
              ),
              );

            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          Navigator.pushNamed(context, pages[index]);
        },
        pages: pages,
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
    return Container(
      padding: EdgeInsets.fromLTRB(15, 7, 10, 1),
      height: 190,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 20, 15), 
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
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
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