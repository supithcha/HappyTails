library globals;

import 'package:cloud_firestore/cloud_firestore.dart';

bool isLoggedIn = false;
String current_user = '';
int current_userID = 0;

Future<String?> getDocumentIdByUserId(String collectionPath, int userId) async {
  String? documentId;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionPath)
      .where('User_ID', isEqualTo: userId)
      .limit(1)
      .get();
  // If there is a matching document, retrieve its ID
  if (querySnapshot.docs.isNotEmpty) {
    documentId = querySnapshot.docs.first.id;
  }
  return documentId;
}

Future<int> getTotalDocumentCount(String collectionName) async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(collectionName);
  QuerySnapshot querySnapshot = await collectionRef.get();
  return querySnapshot.size;
}

Future<int?> getUserIdByName(String name) async {
  int? userID;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('User_username', isEqualTo: name)
      .limit(1)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    userID = int.tryParse(querySnapshot.docs.first.get('User_ID'));
  }
  return userID;
}

Future<String?> getUsernameByID(String id) async {
  String? username;
  // Query Firestore for the document with name equal to the specified value
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('User_ID', isEqualTo: id)
      .limit(1)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    username = querySnapshot.docs.first.get('User_Fullname');
  }
  return username;
}

// Future<int?> getUserIdByEmail(String email) async {
//   int? userId;
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('User')
//       .where('User_email', isEqualTo: email)
//       .limit(1)
//       .get();
//   // If there is a matching document, retrieve its userID
//   if (querySnapshot.docs.isNotEmpty) {
//     // Parse the 'User_ID' field to an integer
//     userId = int.tryParse(querySnapshot.docs.first.get('User_ID'));
//   }
//   // Return userId directly
//   return userId;
// }

// Future<String?> getLocationByID(String id) async {
//   String? location;
//   // Query Firestore for the document with name equal to the specified value
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('User')
//       .where('User_ID', isEqualTo: id)
//       .limit(1)
//       .get();

//   // If there is a matching document, retrieve its userID
//   if (querySnapshot.docs.isNotEmpty) {
//     // Parse the 'User_ID' field to an integer
//     location = querySnapshot.docs.first.get('User_Location');
//   }

//   // Return userId directly
//   return location;
// }

// Future<double?> getLatitudeByPostID(String id) async {
//   double? Latitude;

//   // Query Firestore for the document with name equal to the specified value
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('Post')
//       .where('Post_ID', isEqualTo: id)
//       .limit(1)
//       .get();

//   // If there is a matching document, retrieve its userID
//   if (querySnapshot.docs.isNotEmpty) {
//     // Parse the 'User_ID' field to an integer
//     var temp = querySnapshot.docs.first.get('Latitude');
//     Latitude = double.parse(temp);
//   }

//   // Return userId directly
//   return Latitude;
// }

// Future<double?> getLongitudeByPostID(String id) async {
//   double? Longtitude;

//   // Query Firestore for the document with name equal to the specified value
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('Post')
//       .where('Post_ID', isEqualTo: id)
//       .limit(1)
//       .get();

//   // If there is a matching document, retrieve its userID
//   if (querySnapshot.docs.isNotEmpty) {
//     // Parse the 'User_ID' field to an integer
//     var temp = querySnapshot.docs.first.get('Longtitude');
//     Longtitude = double.parse(temp);
//   }

//   // Return userId directly
//   return Longtitude;
// }
