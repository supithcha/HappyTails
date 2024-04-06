import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'global_variables.dart'; 
import 'welcome.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: isSmallScreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Logo(),
                    _FormContent(),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Center(child: _FormContent()),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
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
          SizedBox(height: 70),
          Center(
            child: Image.asset(
              'assets/logo/full_logo_blue.png',
              height: 250,
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
  String? email;
  String? password;
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;
  int _confirmButton = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 5),
              TextFormField(
                validator: (value) {
                  // add email validation
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  email = value;

                  return null;
                },
                decoration: InputDecoration(
                  // labelText: 'Email',
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
                  // if (value.length < 6) {
                  //   return 'Password must be at least 6 characters';
                  // }
                  setState(() {
                    password = value;
                  });
                  return null;
                },
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  // labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: Color.fromARGB(255, 222, 156, 120),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
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
              SizedBox(height: 5),
              Text(
                'Forget password?',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: const Color.fromARGB(255, 222, 156, 120),
                ),
              ),
              _gap(),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = true;
                      });
                    },
                    shape: CircleBorder(),
                    checkColor: Colors.white,
                    activeColor: Color.fromARGB(255, 222, 156, 120),
                    side: BorderSide(
                      color: Color.fromARGB(255, 222, 156, 120),
                      width: 2.0,
                    ),
                  ),
                  Text("I accept and agree to ",
                      style: TextStyle(fontSize: 13)),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _showTermsOfUseDialog(context);
                      },
                      child: Text(
                        'Terms of Use.',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 74, 173),
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: FilledButton(
                  onPressed: () async {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _agreedToTerms) {
                      _formKey.currentState?.save();

                      // Check if email and password are not null
                      if (email != null && password != null) {
                        // Call loginUser function
                        bool success = await loginUser(email!, password!);

                        if (success) {
                          isLoggedIn = true;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Welcome(username: email),
                            ),
                          );
                        } else {
                          // Handle authentication failure
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Invalid email or password')),
                          );
                        }
                      } else {
                        // Handle case where email or password is null
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email or password is null')),
                        );
                      }
                    } else {
                      // Handle if the terms are not agreed upon
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please agree to the terms')),
                      );
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
                    'Log in',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 74, 173),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}

// from database
Future<bool> loginUser(String username, String password) async {
  try {
    // Retrieve the user document from the "User" collection based on the provided username
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('User_username', isEqualTo: username)
        .get();

    // Check if any user with the provided username exists
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming username is unique)
      DocumentSnapshot userDoc = querySnapshot.docs.first;

      // Get the password stored in the user document
      String storedPassword = userDoc['User_password'];
      int userID = userDoc['User_ID']; // Get the userID from the user document

      // Check if the password matches the stored password
      if (password == storedPassword) {
        current_userID = userID;
        print('Current userID from login page = $current_userID');
        return true; // Return true if the username and password match
      } else {
        return false; // Return false if the password doesn't match
      }
    } else {
      return false; // Return false if no user with the provided username exists
    }
  } catch (e) {
    print('Login error: $e');
    return false; // Return false if an error occurs
  }
}

// from auth
// Future<bool> loginUser(String email, String password) async {
//   try {
//     // Authenticate the user using Firebase Authentication
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     return true; // Return true if authentication is successful
//   } catch (e) {
//     print('Login error: $e');
//     return false; // Return false if an error occurs or authentication fails
//   }
// }

void _showTermsOfUseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: Text('Terms of Use'),
        content: Text('''
          By accessing or using our services, you agree to comply with these Terms of Use. Please read them carefully before using our services.

          1. Acceptance of Terms: By using our services, you agree to be bound by these Terms of Use, which may be updated by us from time to time without notice to you. If you do not agree with these Terms of Use, please do not use our services.

          2. Use of Services: Our services are provided for your personal, non-commercial use only. You may not use our services for any illegal or unauthorized purpose.

          3. User Account: You may be required to create an account to access certain features of our services. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.

          4. Privacy: Your use of our services is also governed by our Privacy Policy. Please review our Privacy Policy to understand our practices.

          5. Intellectual Property: The content on our services, including text, graphics, logos, images, and software, is the property of our company and is protected by intellectual property laws. You may not use, reproduce, or distribute any content from our services without our prior written consent.

          6. Limitation of Liability: Our company shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of our services.

          7. Governing Law: These Terms of Use shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions.

          By using our services, you agree to these Terms of Use. If you have any questions about these Terms of Use, please contact us.
          '''),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 74, 173),
                )),
          ),
        ],
      );
    },
  );
}
