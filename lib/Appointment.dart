import 'package:flutter/material.dart';
import 'package:happytails/Vaccination.dart';
import 'package:happytails/Veterinary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Futura',
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 2,
        child: Appointment(),
      ),
    );
  }
}

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
        title: Text(
          'Appoinment', 
          style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          //_topBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Veterinary(),
                Vaccination(),
              ],
            
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize _appBar({required Widget title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(106),
      child: Container(
        decoration: _boxDecoration(),
        child: Column(
          children: [
            _topBar(),
            _tabBar(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      gradient: LinearGradient(
        
        colors: [
          Colors.white,
          Colors.indigo.shade200,
          Colors.indigo.shade400,
          Colors.indigo.shade700,
          Colors.indigo.shade900,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _topBar() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Appoinment',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.blueGrey.shade300,
      onTap: (index) {
        setState(() {
          tabController.index = index;
        });
      },
    tabs: [
      Tab(
        text: 'Veterinary',
      ),
      Tab(
        text: 'Vaccination',
      ),
    ],
    );
  }
}
