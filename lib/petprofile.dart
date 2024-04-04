import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';


class Petprofile extends StatefulWidget {
  const Petprofile({super.key});

  @override
  State<Petprofile> createState() => _PetprofileState();
}

class _PetprofileState extends State<Petprofile> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Pet").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return ListTile(
                title: Text(snapshot.data?.docs[index]["Pet_Name"] ?? ''),
                subtitle: Text('- Pet_Allergy: ${doc['Pet_Allergy']} \n- Pet_Breed: ${doc['Pet_Breed']} '),
              );
            },
          );
        },
      ),
    );
  }
}
