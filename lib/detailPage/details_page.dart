import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String date;
  final String description;
  final String petName;
  final String image; // Change image to accept image path
  final String phone;
  final String appointmentType;
  final String address;
  final String time;
  final List<String> services;

  DetailsPage({
    required this.date,
    required this.description,
    required this.petName,
    required this.image, // Change image to accept image path
    required this.phone,
    required this.appointmentType,
    required this.address,
    required this.time,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Page',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              height: 200,
              child: Image.asset(
                image, // Use the provided image path
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$description',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.indigo.shade900),
                ),
                Text('Date: $date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.indigo.shade900)),
                SizedBox(height: 2),
                Text('Type of appointments: $appointmentType',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
                SizedBox(height: 5), // Add some space
                Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    width: 85, // Adjust the width as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.done, color: Colors.white),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text('Success',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text('Pet Name: $petName'),
                Text('Phone: $phone'),
                Text('$time'),
                Text('$address'),
                Divider(), //Line
                Text('Services',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo.shade900)),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: services
                      .map((service) => Text('• $service'))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
