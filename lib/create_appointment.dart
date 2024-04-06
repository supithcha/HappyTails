import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global_variables.dart' as Globalvar;

class PetAppointment {
  final String date;
  final String time;
  final String type;
  final String pet;
  final String location;
  // final String status;
  final String note;
  final String apptId;

  PetAppointment({
    required this.date,
    required this.time,
    required this.type,
    required this.pet,
    required this.location,
    // required this.status,
    required this.note,
    required this.apptId,
  });
}

class CreatePetApptPage extends StatefulWidget {
  const CreatePetApptPage({Key? key}) : super(key: key);

  @override
  _CreatePetApptPageState createState() => _CreatePetApptPageState();
}

class _CreatePetApptPageState extends State<CreatePetApptPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _date;
  String? _time;
  String? _selectedType;
  String? _selectedPet;
  String? _location;
  // String? _status;
  String? _note;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<String> appointmentTypes = ['Vaccination', 'Veterinary'];
  List<String> appointmentStatuses = ['Pending', 'Complete'];
  List<String> petNames = []; // To store fetched pet names
  @override
  void initState() {
    super.initState();
    fetchPetNames(); // Fetch pet names when the widget initializes
  }

  Future<void> fetchPetNames() async {
    try {
      // Fetch pet names from Firestore collection 'Pets' filtered by current_userID
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Pet')
          .where('User_ID', isEqualTo: Globalvar.current_userID)
          .get();
      setState(() {
        petNames =
            snapshot.docs.map((doc) => doc['Pet_Name'] as String).toList();
      });
    } catch (e) {
      print('Failed to fetch pet names: $e');
    }
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      String date = _dateController.text.trim();
      String time = _timeController.text.trim();
      String type = _selectedType!;
      String pet = _petController.text.trim();
      String location = _locationController.text.trim();
      // String status = _status ?? appointmentStatuses[0]; // Default value
      String note = _noteController.text.trim();

      // Combine date and time into one value
      String apptDateTime = '$date $time';

      // Store data in Firebase
      try {
        await FirebaseFirestore.instance.collection('Pet appointment').add({
          'Appt_DateTime': apptDateTime,
          'Appt_Type': type,
          'Appt_Pet': pet,
          'Appt_Location': _location,
          // 'Appt_Status': status,
          'Appt_Note': _note,
          'User_ID': Globalvar.current_userID, // Include current_userID
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment saved successfully')),
        );

        // Clear input fields
        _dateController.clear();
        _timeController.clear();
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
              // Date of Appointment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date of Appointment'),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                    ),
                    readOnly: true, // Make the field read-only
                    controller: TextEditingController(
                      text: _date ?? '', // Display the selected date
                    ),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900), // Allow only future dates
                        lastDate: DateTime(
                            2100), // Example last date, you can adjust as needed
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _date = pickedDate.toString().substring(0, 10);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select appointment date";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _date = value ?? '';
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time of Appointment'),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: _time ?? '',
                    ),
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _time = pickedTime.format(context);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select appointment time";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _time = value ?? '';
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Type of Appointment
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of Appointment',
                    ),
                    SizedBox(height: 8),
                    Stack(
                      children: [
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
                            if (value == null || value.isEmpty) {
                              return 'Please select the appointment type';
                            }
                            return null;
                          },
                        ),
                        Positioned(
                          top: 3, // Adjust the position of the icon as needed
                          right: 0,
                          child: IconButton(
                            icon:
                                Icon(Icons.drive_file_rename_outline_outlined),
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
              SizedBox(height: 20.0),
              // Pet
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pet',
                    ),
                    SizedBox(height: 8),
                    Stack(
                      children: [
                        petNames.isNotEmpty
                            ? DropdownButtonFormField<String>(
                                value: _selectedPet,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPet = newValue;
                                  });
                                },
                                items: petNames.map((pet) {
                                  return DropdownMenuItem(
                                    value: pet,
                                    child: Text(pet),
                                  );
                                }).toList(),
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
                                  if (value == null || value.isEmpty) {
                                    return 'Please select your pet';
                                  }
                                  return null;
                                },
                              )
                            : TextFormField(
                                controller: _petController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 16.0,
                                  ),
                                  labelText: 'Enter Pet Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your pet name';
                                  }
                                  return null;
                                },
                              ),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: IconButton(
                            icon:
                                Icon(Icons.drive_file_rename_outline_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              // Location
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter appointment location';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _location = value;
                          },
                        ),
                        Positioned(
                          top: 3, // Adjust the position of the icon as needed
                          right: 0,
                          child: IconButton(
                            icon:
                                Icon(Icons.drive_file_rename_outline_outlined),
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
              SizedBox(height: 20.0),
              // Note
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
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
                              vertical: 72.0,
                              horizontal: 16.0,
                            ),
                          ),
                          onSaved: (value) {
                            _note = value;
                          },
                        ),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: IconButton(
                            icon:
                                Icon(Icons.drive_file_rename_outline_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              // Confirm Button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.8, // 80% of the screen width
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _saveAppointment,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey.shade400, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Border radius
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
