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

Future<String?> getUsernameByID(int id) async {
  String? username;
  // Query Firestore for the document with name equal to the specified value
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('User_ID', isEqualTo: id)
      .limit(1)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    username = querySnapshot.docs.first.get('User_username');
    print('Get username: $username');
  }
  return username;
}

