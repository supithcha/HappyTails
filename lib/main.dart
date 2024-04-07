// Start Page
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happytails/Appointment.dart';
import 'package:happytails/clinic_page.dart';
import 'package:happytails/firebase_options.dart';
import 'package:happytails/homepage.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/start_pet_appt.dart';
import 'package:happytails/start_pet_profile.dart';
import 'package:happytails/tips_and_tricks.dart';
import 'package:happytails/userprofile.dart';
import 'global_variables.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RoutePaths.record: (context) => AppointmentAll(),
        RoutePaths.clinic: (context) => MapClinicPage(title: 'Nearby Clinics'),
        RoutePaths.home: (context) => Homepage(),
        RoutePaths.guide: (context) => TipsPage(title: 'Tips and Tricks'),
        RoutePaths.profile: (context) => UserProfilePage(),
      },
      home: AuthenticationWrapper(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Show a loading page while checking authentication
//           return const HomepageLoading();
//         } else {
//           // User is signed in, show the homepage
//           if (snapshot.hasData) {
//             isLoggedIn = true;
//             return const Homepage();
//           }
//           // User is not signed in, redirect to sign-in page
//           else {
//             isLoggedIn = false;
//             return const SignInPage();
//           }
//         }
//       },
//     );
//   }
// }
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading page while checking authentication
          return const HomepageLoading();
        } else {
          // Check if the user is signed in
          if (snapshot.hasData) {
            // User is signed in, show the homepage
            isLoggedIn = true;
            return const Homepage();
          } else {
            // Show the loading page if no user data is available
            return const HomepageLoading();
          }
        }
      },
    );
  }
}



// class HomepageLoading extends StatelessWidget {
//   const HomepageLoading({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Future.delayed(Duration(seconds: 5)),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Scaffold(
//             body: Container(
//               color: Color(0xff004aad),
//               child: Center(
//                 child: Image.asset(
//                   'assets/logo/full_logo_white.png',
//                   height: 300,
//                 ),
//               ),
//             ),
//           );
//         } else {
//           // Show loading indicator while waiting for the delay
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class HomepageLoading extends StatelessWidget {
  const HomepageLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          });
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
        } 
        else {
          // Show loading indicator while waiting for the delay
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
        }
      },
    );
  }
}
