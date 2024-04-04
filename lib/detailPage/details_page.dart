import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String date;
  final String description;
  final String petName;
  final String image2 = 'assets/Appointment/PetCenter.jpg';
  final String phone;

  final String Type = "Veterinary";
  final String address = "Address: Mars Petcare Company Limited, Panthong District, Chonburi Province, Thailand.";
  final String time = "Open: 10.00-22.00";
  final List<String> services = ["Regular check-ups", "Diagnostic", "Dental Care"];
  final List<String> services2 = ["Nutritional Counseling", "Pharmacy Services", "Behavioral Counseling"];
  final String customerName = 'Deniel Happy';
  final String number = '6401467';

  DetailsPage({
    required this.date,
    required this.description,
    required this.petName,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
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
                image2,
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
                Text('$description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.indigo.shade900)),
                Text('Date: $date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo.shade900)),
                SizedBox(height: 2),
                Text('Type of appointments: $Type', style: TextStyle(fontSize: 15, color: Colors.black)),
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
                          child: Text('Success', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text('Pet Name: $petName'),
                Text('Customer Name: $customerName'),
                Text('ID: $number'),
                SizedBox(height: 5),
                Text('Phone: $phone'),
                Text('$time'),
                Text('$address'),
                Divider(), //Line
                Text('Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo.shade900)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: services.map((service) => Text('• $service')).toList(),
                    ),
                    SizedBox(width: 80), // Adjust the space between columns
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: services2.map((service) => Text('• $service')).toList(),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
