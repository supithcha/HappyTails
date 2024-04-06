import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global_variables.dart'; 

class CreatePetApptPage extends StatefulWidget {
  const CreatePetApptPage({Key? key}) : super(key: key);

  @override
  _CreatePetApptPageState createState() => _CreatePetApptPageState();
}

class _CreatePetApptPageState extends State<CreatePetApptPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<String> appointmentTypes = ['Vaccination', 'Veterinary'];
  List<String> appointmentStatuses = ['Pending', 'Complete'];
  String? _selectedType;
  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      String date = _dateController.text.trim();
      String time = _timeController.text.trim();
      // String type = _typeController.text.trim();
      String type = _selectedType!;
      String pet = _petController.text.trim();
      String location = _locationController.text.trim();
      String status = _statusController.text.trim();
      String note = _noteController.text.trim();

      // Combine date and time into one value
      String apptDateTime = '$date $time';
  
      // Store data in Firebase
      try {
        await FirebaseFirestore.instance.collection('Pet appointment').add({
          'Appt_DateTime': apptDateTime,
          'Appt_Type': type,
          'Appt_Pet': pet,
          'Appt_Location': location,
          'Appt_Status': status,
          'Appt_Note': note,
          'User_ID': current_userID, // Include current_userID
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment saved successfully')),
        );

        // Clear input fields
        _dateController.clear();
        _timeController.clear();
        _typeController.clear();
        _petController.clear();
        _locationController.clear();
        _noteController.clear();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save appointment')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Appointment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vaccination Status',
                      ),
                      SizedBox(height: 8),
                      Stack(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                            validator: (value) {
                              // Add validation if needed
                              return null;
                            },
                            onSaved: (value) {
                              // _location = value;
                            },
                          ),
                          Positioned(
                            top: 3, // Adjust the position of the icon as needed
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                  Icons.drive_file_rename_outline_outlined),
                              onPressed: () {
                                // Add your edit icon onPressed logic here
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date of Appointment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time of Appointment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                items: appointmentTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Type of Appointment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the appointment type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _petController,
                decoration: InputDecoration(labelText: 'Pet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the pet name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Note'),
                validator: (value) {
                  // Note is optional, so no validation needed
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: Text('Save Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
