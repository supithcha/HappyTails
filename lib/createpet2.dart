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
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PetInformation {
  final String allergies;
  final String breed;
  final String dob;
  final String gender;
  final String petid;
  final String Pet_Image;
  final String medicalHistory;
  final String medication;
  final String name;
  final String petType;
  final String vaccinationStatus;
  final String weight;
  final int userID;

  PetInformation({
    required this.allergies,
    required this.breed,
    required this.dob,
    required this.gender,
    required this.petid,
    required this.Pet_Image,
    required this.medicalHistory,
    required this.medication,
    required this.name,
    required this.petType,
    required this.vaccinationStatus,
    required this.weight,
    required this.userID,
  });
}

class CreatePetProfilePagetwo extends StatefulWidget {
  @override
  final String selectedPetName;

  const CreatePetProfilePagetwo({Key? key, required this.selectedPetName})
      : super(key: key);
  _CreatePetProfilePagetwoState createState() =>
      _CreatePetProfilePagetwoState();
}

class _CreatePetProfilePagetwoState extends State<CreatePetProfilePagetwo> {
  final _formKey = GlobalKey<FormState>();
  String? _allergies;
  String? _breed;
  String? _dob;
  String? _gender;
  String? _petid;
  String? _Pet_Image;
  String? _medicalHistory;
  String? _medication;
  String? _name;
  String? _petType;
  String? _vaccinationStatus;
  String? _weight;
  int? _userID;
  int _selectedIndex = 0;

  final firestore = FirebaseFirestore.instance;
  File? _image;

  // Use the defined route paths
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];

  Future<void> _savePetInformation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final petInfo = {
        'Pet_Allergy': _allergies,
        'Pet_Breed': _breed,
        'Pet_DOB': _dob,
        'Pet_Gender': _gender,
        'Pet_ID': _petid,
        'Pet_Image': _Pet_Image,
        'Pet_Med_History': _medicalHistory,
        'Pet_Medication': _medication,
        'Pet_Name': _name,
        'Pet_Type': widget.selectedPetName,
        'Pet_Vacc_status': _vaccinationStatus,
        'Pet_Weight': _weight,
        'User_ID': current_userID,
      };
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No selected image')),
        );
        petInfo['Pet_Image'] = 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
      }
      try {
        if (_image != null) {
          String imgURL = await uploadImage(_image);
          _Pet_Image = imgURL;
          petInfo['Pet_Image'] = imgURL;
          print('Image Url = $_Pet_Image');
        }

        String petid = Uuid().v4();
        _petid = petid;
        petInfo['User_ID'] = current_userID;
        petInfo['Pet_ID'] = petid;

        await FirebaseFirestore.instance.collection('Pet').add(petInfo);

        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfilePage(petid: petid),
            ),
          );
        });
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
                      if (_image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            _image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (_image == null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        // onPressed: _pickAndNavigateToNextPage,
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            _image = File(image.path);
                            print('Image selected');
                            print('File path: ${image.path}');
                          }
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
                              onPressed: () {},
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
        initialIndex: 2, // Initial selected index
        // pages: pages
      ),
    );
  }
}

Future<String> uploadImage(File? image) async {
  var imageName = DateTime.now().millisecondsSinceEpoch.toString();
  print('imageName = $imageName');

  // Get the temporary directory path
  String tempDirPath = (await getTemporaryDirectory()).path;

  // Resize the image and save it to a new file
  final resizedImage = await FlutterImageCompress.compressAndGetFile(
    image!.path,
    '$tempDirPath/$imageName.jpg', // Specify a new path for the compressed image
    quality: 50, // Adjust quality as needed
    minWidth: 800, // Set minimum width
    minHeight: 600, // Set minimum height
  );

  File file = File(resizedImage!.path);
  var storageRef =
      FirebaseStorage.instance.ref().child('pet_image/$imageName.jpg');
  print('storageRef = $storageRef');

  var uploadTask = storageRef.putFile(file);
  print('uploadTask = $uploadTask');

  try {
    await uploadTask; // Wait for the upload to complete
    var downloadUrl = await storageRef.getDownloadURL();
    print('downloadUrl = $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return 'Error'; // Return an empty string or handle the error as needed
  }
}
