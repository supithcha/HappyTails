import 'package:flutter/material.dart';
import 'package:happytails/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: isSmallScreen
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _Logo(),
                    _FormContent(),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Center(child: _FormContent()),
                      ),
                    ],
                  ),
                )),
    ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Center(
            child: Image.asset(
              'assets/logo/full_logo_blue.png',
              height: 250,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              'Please enter your information',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  String? fullName;
  String? username;
  String? password;
  String? confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _confirmButton = -1;
  int _insertedButtonIndex = 0;
  // bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full name',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 5),
            TextFormField(
              validator: (value) {
                // add fullname validation
                if (value == null || value.isEmpty) {
                  return 'Please enter your fullname';
                }
                fullName = value;
                // _insertedButtonIndex = 1;
                _insertedButtonIndex = _insertedButtonIndex + 1;
                // _confirmButton = 1;
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your fullname',
                // border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 222, 156, 120)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 222, 156, 120)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            _gap(),
            Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 5),
            TextFormField(
              validator: (value) {
                // add validation
                if (value == null || value.isEmpty) {
                  // _validate = true;
                  return 'Please enter your username';
                }
                // bool emailValid = RegExp(
                //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(value);
                // if (!emailValid) {
                //   return 'Please enter a valid email';
                // }
                setState(() {
                  username = value;
                  // _insertedButtonIndex = 2;
                  _insertedButtonIndex = _insertedButtonIndex + 1;
                  // _confirmButton = 2;
                });
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your username',
                // border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 222, 156, 120)), // Border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 156,
                          120)), // Border color when enabled but not focused
                ),
                // errorText: _validate ? 'Please enter a valid username' : null,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            _gap(),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 5),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                setState(() {
                  password = value;
                  // _insertedButtonIndex = 3;
                  _insertedButtonIndex = _insertedButtonIndex + 1;
                  // _confirmButton = 3;
                });
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                // border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 222, 156, 120)), // Border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 156,
                          120)), // Border color when enabled but not focused
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            _gap(),
            Text(
              'Confirm Password',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 5),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Passwords do not match.';
                }
                if (value != password) {
                  return 'Passwords do not match.';
                }
                setState(() {
                  confirmPassword = value;
                  // _insertedButtonIndex = 4;
                  _insertedButtonIndex = _insertedButtonIndex + 1;
                  //  _confirmButton = 4;
                });
                return null;
              },
              obscureText: !_isPasswordConfirmVisible,
              decoration: InputDecoration(
                hintText: 'Re-enter your password',
                // border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 222, 156, 120)), // Border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 156,
                          120)), // Border color when enabled but not focused
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            _gap(),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(4)),
            //     ),
            //     child: const Padding(
            //       padding: EdgeInsets.all(10.0),
            //       child: Text(
            //         'Sign Up',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     onPressed: () {
            //       if (_formKey.currentState?.validate() ?? false) {
            //         print("Fullname: $fullName");
            //         print("UserName: $userName");
            //         print("Email: $email");
            //         print("Password: $password");
            //         print("ConfirmPassword: $confirmPassword");
            //       }
            //     },
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: FilledButton(
                onPressed: () async {
                  setState(() {
                    // If any option is selected (not -1), change the button color to blue, otherwise grey
                    // _insertedButtonIndex != -1
                    //     ? _confirmButton = 0
                    //     : _insertedButtonIndex = -1;
                    _confirmButton =
                        (_insertedButtonIndex == 4) ? 0 : -1;
                  });
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Check if all inputs are not null
                    if (fullName != null &&
                        username != null &&
                        password != null &&
                        confirmPassword != null) {
                      // Call signupUser function
                      bool success =
                          await signupUser(fullName!, username!, password!);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Register successfully')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      } else {
                        // Handle authentication failure
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User already exists.')),
                        );
                      }
                    } else {
                      // Handle case where email or password is null
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Incomplete information.')),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: _confirmButton != -1
                      ? MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 74, 173)) // Blue
                      : MaterialStateProperty.all(
                          Color.fromARGB(255, 196, 196, 196)), // Gray
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 40.0)),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _gap(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to the SignUp page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                child: const Text("Already have an account? Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}

// Create new user when pressing register
Future<bool> signupUser(
    String fullName, String username, String password) async {
  try {
    // Check if user already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('User_username', isEqualTo: username)
        .get();

    // If a document with the provided username exists, return false
    if (querySnapshot.docs.isNotEmpty) {
      print('User already exists');
      return false;
    }

    // Initialize the new User_ID
    int newUserId = 1;

    // Get the highest User_ID from existing documents
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('User')
        .orderBy('User_ID', descending: true)
        .limit(1)
        .get();

    // If there are existing users, increment the new User_ID
    if (userSnapshot.docs.isNotEmpty) {
      newUserId = userSnapshot.docs.first['User_ID'] + 1;
    }

    // Create a new user with username and password using FirebaseAuth
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:
          '$username@HappyTails.com', // Assuming you append a domain to the username
      password: password,
    );

    // Get the UID of the newly created user
    String uid = userCredential.user!.uid;

    // Store additional user data in Firestore
    await FirebaseFirestore.instance.collection('User').doc(uid).set({
      'User_ID': newUserId, // Use the calculated User_ID
      'User_Fullname': fullName,
      'User_username': username,
      'User_password': password,
      'User_Img': ""
    });
    print("Register Successfully");
    return true; // Return true if signup is successful
  } catch (e) {
    print('Signup error: $e');
    return false; // Return false if an error occurs during signup
  }
}
