import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'option_pet_select.dart';
import 'package:happytails/authentication/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome.dart';
class Profile {
  final String email;
  final String password;

  Profile({
    required this.email, 
    required this.password,
    });
}

class LoginGG extends StatefulWidget {
  const LoginGG({Key? key}) : super(key: key);

  @override
  State<LoginGG> createState() => _LoginGGState();
}

class _LoginGGState extends State<LoginGG> {
  bool _agreedToTerms = false;
  // variable to keep track of the selected index
  int _confirmButton = -1;
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/logo/full_logo_blue.png',
                  height: 270,
                ),
              ),
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 5),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 222, 156,
                                120)), // Border color when focused
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

                    onSaved: (value) {
                    _password = value;
                },

                  ),
                  Positioned(
                    top: 0, // Adjust the position of the icon as needed
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color.fromARGB(255, 222, 156, 120),
                      ),
                      onPressed: () {
                        // setState(() {
                        //   _obscureText = !_obscureText;
                        // });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text(
                'Forget password?',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: const Color.fromARGB(255, 222, 156, 120),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value!;
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
                  onPressed: () {
                    signInWithGoogle(context);
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
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: FilledButton(
                  onPressed: () {
                    signInWithGoogle(context);
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
                    'Signin with Google',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  InkWell(
                    onTap: () {
                      // Navigate to Register page
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

  Future<void> signInWithGoogle(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '577250430112-teqc5e1kqb835dfn9aasnaol522ga7lh.apps.googleusercontent.com',
    scopes: [
      'email',
    ],
  );

  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      // User cancelled the sign-in process
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user != null) {
      // Sign in successful
      print('User signed in: ${user.displayName}');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome()));
    } else {
      print('Failed to sign in');
    }
  } catch (error) {
    print('Error signing in: $error');
  }
}

//   signInWithGoogle() async {
//     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//     AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
//     print(user.user?.displayName);
// }


}


