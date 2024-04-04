// Start Page
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happytails/Appointment.dart';
import 'package:happytails/clinic_page.dart';
import 'package:happytails/createpetprofile.dart';
import 'package:happytails/firebase_options.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/signup.dart';
import 'package:happytails/start_pet_profile.dart';
import 'package:happytails/tips_and_tricks.dart';
import 'option_pet_select.dart';
import 'login.dart';
import 'petprofile.dart';
import 'welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() {
//   runApp(const MyApp());
// }

void main () async {
  WidgetsFlutterBinding.ensureInitialized () ;
  await Firebase.initializeApp (
    options : DefaultFirebaseOptions . currentPlatform ,
  );
  runApp ( const MyApp () );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const HomepageLoading(),
      routes: {
        // MUST replace when ทำของจริง ตอนนี้แปะไปก่อนเฉยๆ
        RoutePaths.record: (context) => Appointment(),
        RoutePaths.clinic: (context) => SignInPage(),
        RoutePaths.home: (context) => SignUpPage(),
        RoutePaths.guide: (context) => TipsPage(title: 'Tips and Tricks'),
        RoutePaths.profile: (context) => StartPetProfilePage(),
      },
      home: const OptionPetPage(),
    );
  }
}



// class HomepageLoading extends StatelessWidget {
//   const HomepageLoading({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           // builder: (context) => Welcome(),
//           builder: (context) => Petprofile(),
//         ),
//       );
//     });

//     return Scaffold(
//       body: Container(
//         color: Color(0xff004aad),
//         child: Center(
//           child: Image.asset(
//             'assets/logo/full_logo_white.png',
//             height: 300,
//           ),
//         ),
//       ),
//     );
//   }
// }

class HomepageLoading extends StatelessWidget {
  const HomepageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder to wait for the delay
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance!.addPostFrameCallback((_) { // Once the delay is done, navigate to Petprofile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
            );
          });
        }

        return Scaffold(
          body: Container(
            color: Color(0xff004aad),
            child: Center(
              child: Image.asset(
                'assets/logo/full_logo_white.png',
                height: 300,
              ),
            ),
          ),
        );
      },
    );
  }
}



