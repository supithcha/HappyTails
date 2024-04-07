import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happytails/create_appointment.dart';
import 'package:happytails/details_page.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:happytails/start_pet_appt.dart';
import 'global_variables.dart' as Globalvar;

class Veterinary extends StatelessWidget {
  const Veterinary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            // Use FutureBuilder to fetch data from Firestore
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Pet appointment')
                  .where('User_ID', isEqualTo: Globalvar.current_userID)
                  .where('Appt_Type', isEqualTo: 'Veterinary')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the data is still loading
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If there's an error fetching the data
                  return Text('Error: ${snapshot.error}');
                }
                final documents = snapshot.data!.docs;
                int itemCount = documents.length;
                // if (itemCount == 0) {
                //   // If there are no vaccination appointments
                //   WidgetsBinding.instance!.addPostFrameCallback((_) {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => StartPetApptPage()),
                //     );
                //   });
                //   return Container(); // Return an empty container for now
                // } else {
                  // If the data is successfully fetched
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final document = documents[index];
                          return _ProductBox(
                            Date: document['Appt_Date'],
                            description: document['Appt_Location'],
                            Petname: document['Appt_Pet'],
                            image: "assets/Appointment/hospital.png",
                            Phone:
                                " Tel: 1119", // You can change this to the actual phone number if it's available in the document
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    date: document['Appt_Date'],
                                    description: document['Appt_Location'],
                                    petName: document['Appt_Pet'],
                                    phone:
                                        " Tel: 1119", // You can change this to the actual phone number if it's available in the document
                                    appointmentType:
                                        "Veterinary", // Specify the appointment type
                                    address: "Address for Veterinary",
                                    time: "Open: 10.00-22.00",
                                    services: [
                                      "Regular check-ups",
                                      "Diagnostic",
                                      "Dental Care"
                                    ],
                                    image: "Appointment/PetCenter.jpg",
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
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
                                builder: (context) => CreatePetApptPage(),
                              ),
                            );
                          },
                          color: const Color.fromARGB(255, 0, 74, 173),
                          icon: const Icon(Icons.add_circle_rounded, size: 42.0),
                        ),
                      ),
                    ],
                  );
                // }
              },
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
