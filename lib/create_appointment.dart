import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happytails/Appointment.dart';
import 'global_variables.dart' as Globalvar;
import 'package:uuid/uuid.dart';

class PetAppointment {
  final String date;
  final String time;
  final String type;
  final String pet;
  final String location;
  final String note;
  final String apptId;

  PetAppointment({
    required this.date,
    required this.time,
    required this.type,
    required this.pet,
    required this.location,
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
  String? _note;

  final TextEditingController _petController = TextEditingController();

  List<String> appointmentTypes = ['Vaccination', 'Veterinary'];
  List<String> petNames = []; // To store fetched pet names
  @override
  void initState() {
    super.initState();
    fetchPetNames(); // Fetch pet names when the widget initializes
  }

  Future<void> fetchPetNames() async {
    try {
      // Fetch pet names from Firestore collection 'Pet' filtered by current_userID
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Pet')
          .where('User_ID', isEqualTo: Globalvar.current_userID)
          .get();
      setState(() {
        petNames =
            snapshot.docs.map((doc) => doc['Pet_Name'] as String).toList();
        print(petNames);
      });
    } catch (e) {
      print('Failed to fetch pet names: $e');
    }
  }

// Function to fetch Pet_ID by Pet_Name
  Future<String?> fetchPetIdByPetName(String petName) async {
    try {
      // Fetch pet id from Firestore collection 'Pet' filtered by current_userID and Pet_Name
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Pet')
          .where('User_ID', isEqualTo: Globalvar.current_userID)
          .where('Pet_Name', isEqualTo: petName)
          .get();
      // Check if snapshot has any documents
      if (snapshot.docs.isNotEmpty) {
        print('Document found');
        // Return Pet_ID
        return snapshot.docs.first['Pet_ID'] as String?;
      } else {
        print('Document not found');
        return null;
      }
    } catch (e) {
      print('Failed to fetch pet id by pet name: $e');
      return null;
    }
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      String date = _date ?? '';
      String time = _time ?? '';
      String type = _selectedType ?? '';
      String pet = _selectedPet ?? '';
      String location = _location ?? ''; // Use _location variable
      String note = _note ?? ''; // Use _note variable

      print('Date: $date');
      print('Time: $time');
      print('Type: $type');
      print('Pet: $pet');
      print('Location: $location');
      print('Note: $note');

      // Fetch Pet_ID corresponding to the selected petName
      String? petId = await fetchPetIdByPetName(pet);
      print('Fetched Pet_ID: $petId');
      // Check if Pet_ID is fetched
      // if (petId != null) {
        String apptid = Uuid().v4();
        print('Generate Appt_ID = $apptid \n');

        // Store data in Firebase
        try {
          await FirebaseFirestore.instance.collection('Pet appointment').add({
            'Appt_Date': date,
            'Appt_Time': time,
            'Appt_Type': type,
            'Appt_Pet': pet,
            'Appt_Location': location,
            'Appt_Note': note,
            'Pet_ID': petId, // Include Pet_ID
            'User_ID': Globalvar.current_userID, // Include current_userID
            'Appt_ID': apptid,
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment saved successfully')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentAll(),
            ),
          );
        } catch (e) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save appointment')),
          );
        }
      // } else {
      //   // Show error message if Pet_ID is not fetched
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to fetch Pet_ID')),
      //   );
      // }
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
              // Date of Appointment section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date of Appointment'),
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      SizedBox(
                        height: 70,
                        child: TextFormField(
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
                          minLines:
                              null, // Set minLines to null for minimum height
                          maxLines: null, // Allow any number of lines
                          keyboardType:
                              TextInputType.multiline, // Enable multiline input
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime(1900), // Allow only future dates
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
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.calendar_month_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Time section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time of Appointment'),
                  SizedBox(height: 15),
                  Stack(
                    children: [
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
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.access_time_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              // Type of Appointment section
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of Appointment',
                    ),
                    SizedBox(height: 15),
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
                              vertical: 15.0,
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
                          top: 3,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.arrow_drop_down_circle_rounded),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              // Pet section
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pet',
                    ),
                    SizedBox(height: 15),
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
                                    vertical: 20.0,
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
                                    vertical: 17.0,
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
              SizedBox(height: 15.0),
              // Location section
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                    ),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 17.0,
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
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              // Note section
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

              SizedBox(height: 25.0),
              // Confirm Button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.8, // 80% of the screen width
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save(); // Save form data
                        _saveAppointment(); // Call _saveAppointment method
                      }
                    },
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
