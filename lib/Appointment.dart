import 'package:flutter/material.dart';
import 'package:happytails/Veterinary.dart';
import 'package:happytails/Vaccination.dart';
import 'package:happytails/route_paths.dart';
import 'package:happytails/bottom_nav_bar.dart';

// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
  

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Futura',
//         primaryColor: Colors.white,
//       ),
//       home: DefaultTabController(
//         length: 2,
//         child: AppointmentAll(),
//       ),
//     );
//   }
// }

class AppointmentAll extends StatefulWidget {
  const AppointmentAll({Key? key}) : super(key: key);

  @override
  _AppointmentAllState createState() => _AppointmentAllState();
}

class _AppointmentAllState extends State<AppointmentAll> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  // Use the defined route paths
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];
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
          'Appointment',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
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

  // PreferredSize _appBar({required Widget title}) {
  //   return PreferredSize(
  //     preferredSize: const Size.fromHeight(120),
  //     child: Container(
  //       decoration: _boxDecoration(),
  //       child: Column(
  //         children: [
  //           _topBar(),
  //           _tabBar(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  PreferredSize _appBar({required Widget title}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
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
    alignment: Alignment.bottomCenter, // Align bottom center
    padding: EdgeInsets.only(top:50,bottom: 10),
    child: Text(
      'Appointment',
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
