import 'package:flutter/material.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:happytails/global_variables.dart';
import 'package:happytails/main.dart';
import 'package:happytails/route_paths.dart';
import 'global_variables.dart';
import 'signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'global_variables.dart';
import 'welcome.dart';
import 'global_variables.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    var _selectedIndex = 0;
    final List<String> pages = [
      RoutePaths.record,
      RoutePaths.clinic,
      RoutePaths.home,
      RoutePaths.guide,
      RoutePaths.profile,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: isSmallScreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Logo(),
                    _FormContent(),
                    _Logout(),
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

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _confirmButton = -1;

  String? fullname;
  String? username;
  String? password;

  Future<void> fetchUserData(int current_userID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    QuerySnapshot querySnapshot =
        await users.where('User_ID', isEqualTo: current_userID).get();

    if (querySnapshot.size > 0) {
      var userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
      setState(() {
        fullname = userData['User_Fullname'];
        username = userData['User_username'];
        password = userData['User_password'];
      });
      print('Full Name: $fullname');
      print('Username: $username');
      print('Password: $password');
    } else {
      print('User not found');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(
        current_userID); // Call fetchUserData when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
    color: const Color.fromARGB(255, 0, 74, 173),
    borderRadius: BorderRadius.circular(15), // Adjust the value as needed
  ),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _gap(),
                  Text(
                    'Full name',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white,),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: SizedBox(
                      width: 450, // Set the desired fixed width
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value as needed
                          border: Border.all(
                            color: Colors.grey, // Border color
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          fullname ??
                              '', // Display the full name if it's not null
                          style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _gap(),
                  Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white,),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: SizedBox(
                      width: 450, // Set the desired fixed width
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value as needed
                          border: Border.all(
                            color: Colors.grey, // Border color
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          username ??
                              '', // Display the full name if it's not null
                          style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _gap(),
                  Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white,),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: SizedBox(
                      width: 450, // Set the desired fixed width
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value as needed
                          border: Border.all(
                            color: Colors.grey, // Border color
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          password ??
                              '', // Display the full name if it's not null
                          style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  _gap(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
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
        ],
      ),
    );
  }
}

class _Logout extends StatelessWidget {
  const _Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _confirmButton = 0;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(50.0),
        child: FilledButton(
          onPressed: () async {
  logoutAndRedirect(context);
},
          style: ButtonStyle(
            backgroundColor: _confirmButton != -1
                ? MaterialStateProperty.all(
                    Color.fromARGB(255, 0, 74, 173)) // Blue
                : MaterialStateProperty.all(
                    Color.fromARGB(255, 196, 196, 196)), // Gray
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.0)),
          ),
          child: const Text(
            'Sign out',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

void logoutAndRedirect(BuildContext context) {
  FirebaseAuth.instance.signOut();

  // Redirect to HomepageLoading
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomepageLoading()),
  );
}

