// Start Page
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happytails/firebase_options.dart';
import 'welcome.dart';
import 'option_pet_select.dart';
import 'login.dart';
import 'petprofile.dart';
import 'welcome.dart';
// void main() {
//   runApp(const MyApp());
// }

void main () async {
  WidgetsFlutterBinding . ensureInitialized () ;
  await Firebase . initializeApp (
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
      home: const HomepageLoading(),
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
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Once the delay is done, navigate to Petprofile
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Petprofile(),
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



