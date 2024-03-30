import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Petprofile extends StatelessWidget {
  const Petprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( children: [
       SizedBox(height: 25),
       SizedBox(height: 25),
       SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pet profile',
                      ),
                      SizedBox(height: 8),
                      
                    ],
                  ),
                ),

      ]
      )
    );
    
  }
}