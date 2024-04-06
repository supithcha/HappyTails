import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:happytails/petprofile.dart';
import 'package:happytails/route_paths.dart';
import 'option_pet_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'global_variables.dart'; 

class PetInformation {
  final String name;
  final String gender;
  final String breed;
  final String dob;
  final String weight;
  final String petType;
  final String vaccinationStatus;
  final String medicalHistory;
  final String allergies;
  final String medication;
  final String doctorAppointment;
  final String Pet_Image;
  final String petid;
  final String userID;

  PetInformation({
    required this.name,
    required this.gender,
    required this.breed,
    required this.dob,
    required this.weight,
    required this.petType,
    required this.vaccinationStatus,
    required this.medicalHistory,
    required this.allergies,
    required this.medication,
    required this.doctorAppointment,
    required this.Pet_Image,
    required this.petid,
    required this.userID,
  });
}

class CreatePetProfilePage extends StatefulWidget {
  @override
  final String selectedPetName;
  const CreatePetProfilePage({Key? key, required this.selectedPetName})
      : super(key: key);
  _CreatePetProfilePageState createState() => _CreatePetProfilePageState();
}

class _CreatePetProfilePageState extends State<CreatePetProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _gender;
  String? _breed;
  String? _dob;
  String? _weight;
  String? _vaccinationStatus;
  String? _medicalHistory;
  String? _allergies;
  String? _medication;
  String? _doctorAppointment;
  String? _Pet_Image;
  String? _petid;
  String? userID;

  int _selectedIndex = 0;
  
  // Use the defined route paths
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];

  Uint8List? _img;
  // int current_userID ;

  void selectedImage() async {
    final imagePicker = ImagePicker();
    final XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      final bytes = await img.readAsBytes();
      setState(() {
        _img = bytes;
      });
      print('Image selected and _img set');
    } else {
      print('No image selected');
    }
  }

  Future<void> _savePetInformation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final petInfo = {
        'Pet_Allergy': _allergies,
        'Pet_Breed': _breed,
        'Pet_DOB': _dob,
        'Pet_Gender': _gender,
        'Pet_Med_History': _medicalHistory,
        'Pet_Medication': _medication,
        'Pet_Name': _name,
        'Pet_Type': widget.selectedPetName,
        'Pet_Vacc_status': _vaccinationStatus,
        'Pet_Weight': _weight,
        'Pet_Image': _Pet_Image,
        'Pet_ID': _petid,
        'User_ID': current_userID,
      };

      String petid = Uuid().v4();
      petInfo['Pet_ID'] = petid;

      try {
        if (_img != null) {
          final imageUrl = await uploadImageToFirestore(_img!);
          print('current_userID = $current_userID');
          petInfo['User_ID'] = current_userID;
          petInfo['Pet_Image'] = imageUrl;
          await FirebaseFirestore.instance.collection('Pet').add(petInfo);
          // print('Pet information saved successfully! \n $petInfo');
          setState(() {
            _petid = petid;
            print('$petid');
           

            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfilePage(petid: petid),
            ),
          );
          });
          print('$petid');
        }
      } catch (e) {
        print('Error saving pet information: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Photo Section
                SizedBox(height: 30),
                Container(
                  height: 200,
                  width: 550,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      if (_img != null)
                        Image.memory(
                          _img!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        // onPressed: _pickAndNavigateToNextPage,
                        onPressed: () {
                          selectedImage();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Name and Gender Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your pet's name";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _name = value;
                                },
                              ),
                            ],
                          ),
                          Positioned(
                            top:
                                30, // Adjust the position of the icon as needed
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
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                // style: TextStyle(
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 17,
                                    horizontal: 15,
                                  ),
                                ),
                                value: _gender,
                                onChanged: (newValue) {
                                  setState(() {
                                    _gender = newValue as String?;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          Positioned(
                            top:
                                30, // Adjust the position of the icon as needed
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
                    ),
                  ],
                ),

                SizedBox(height: 16),
                // Breed and Date of Birth Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Breed or Mix',
                                // style: TextStyle(
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your pet\'s breed';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _breed = value;
                                },
                              ),
                            ],
                          ),
                          Positioned(
                            top:
                                30, // Adjust the position of the icon as needed
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
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date of Birth',
                              ),
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
                                  text: _dob ?? '', // Display the selected date
                                ),
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      _dob = DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your pet's Date of Birth";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _dob =
                                      value ?? ''; // Update the _dob variable
                                },
                              ),
                            ],
                          ),
                          Positioned(
                            top: 30,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                  Icons.drive_file_rename_outline_outlined),
                              onPressed: () {
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weight',
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your pet\'s breed';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _weight = value;
                                },
                              ),
                            ],
                          ),
                          Positioned(
                            top:
                                30, // Adjust the position of the icon as needed
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
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pet type',
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                initialValue: widget
                                    .selectedPetName, // Display the selected pet name
                                readOnly: true, // Make the field read-only
                              ),
                            ],
                          ),
                          Positioned(
                            top:
                                30, // Adjust the position of the icon as needed
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                  Icons.drive_file_rename_outline_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OptionPetPage()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),
                // Health and Medical Information Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Health and Medical Information Section',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Vaccination Status
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
                              _vaccinationStatus = value;
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

                // Medical History
                SizedBox(height: 16),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical History',
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
                              _medicalHistory = value;
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

                // Allergies
                SizedBox(height: 16),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allergies',
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
                              _allergies = value;
                            },
                          ),
                          Positioned(
                            top: 3, // Adjust the position of the icon as needed
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                  Icons.drive_file_rename_outline_outlined),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Medication
                SizedBox(height: 16),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medication',
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
                              _medication = value;
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

                // Doctor Appointment
                SizedBox(height: 16),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor Appointment',
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
                              return null;
                            },
                            onSaved: (value) {
                              _doctorAppointment = value;
                            },
                          ),
                          Positioned(
                            top: 3,
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
                SizedBox(height: 25),
                // Confirm Button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% of the screen width
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _savePetInformation,
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
                          color: Colors.white, // Set text color to white
                          fontWeight: FontWeight.bold, // Set text to bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

Future<String> uploadImageToFirestore(Uint8List img) async {
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    print('See filename: $fileName');
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    print('See ref: ${storageReference.fullPath}');
    // Convert Uint8List to base64 string
    String base64Image = base64Encode(img);
    // print('See base64 Image: $base64Image');
    // await FirebaseFirestore.instance.collection('Pet').add({'base64Image': base64Image});
    return base64Image;
  } catch (e) {
    print('Error uploading image: $e');
    return '';
  }
}

Future<XFile?> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  return pickedImage;
}
