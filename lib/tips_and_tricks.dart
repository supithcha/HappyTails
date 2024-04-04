import 'package:flutter/material.dart';
import 'package:happytails/bottom_nav_bar.dart';
import 'package:happytails/route_paths.dart';

// void main() => runApp(TipsPage());

class Trick {
  final String name;
  final String description;
  final String description2;
  final String image;
  final String context;
  final String age;
  final String personality;
  final String breed;

  Trick(this.name, this.description, this.description2, this.image,
      this.context, this.age, this.personality, this.breed);

  static List<Trick> getTips() {
    List<Trick> items = <Trick>[];
    items.add(Trick(
        "Factor to consider when interpreting your dog's behaviour",
        "Whilst looking out for the behaviours above will help you understand what your dog",
        "Whilst looking out for the behaviours above will help you understand what your dog is feeling, here are some factors to bear in mind:",
        "dog.png",
        "It's essential to consider the specific situation and what's normal for your dog when reading their body language. What might be relaxed behaviour in a home environment can mean something different in a public setting.",
        "Puppies and older dogs will behave very differently due to their stage of development and age-related changes. Puppies are likely to be more energetic and playful, while older dogs tend to be calmer.",
        "Just like people, dogs have their own personalities that influence their behaviour. Some dogs may be more outgoing and confident, while others may be more timid and anxious.",
        "Different dog breeds can have certain behaviours due to selective breeding. For example, herding breeds, such as sheepdogs, may like to herd other animals. However, this does not mean all dogs of a breed will show the same behaviour, as environment, learning and individual personality will also affect how they behave. "));
    items.add(Trick(
        "Pet in Condos: 5 Key considerations",
        "Pet owners look for a condo to live in,they look for pet-friendly building",
        "Pet owners look for a condo to live in, they look for pet-friendly buildings. So when a building prohibits pets you reduce your prospective owners and tenants who want to live there. Your condo may also face criticism as it may be considered discriminatory to prohibit pets. ",
        "cat.png",
        "Share rules around pets in condos",
        "Make your condo pet-friendly",
        "Just like people, dogs have their own personalities that influence their behaviour. Some dogs may be more outgoing and confident, while others may be more timid and anxious.",
        "Different dog breeds can have certain behaviours due to selective breeding. For example, herding breeds, such as sheepdogs, may like to herd other animals. However, this does not mean all dogs of a breed will show the same behaviour, as environment, learning and individual personality will also affect how they behave. "));

    return items;
  }
}

// class TipsPage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Tips and Tricks'),
//     );
//   }
// }

class TipsPage extends StatefulWidget {
  TipsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int _selectedIndex = 0;
  late List<Trick> items;
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];
  

  @override
  void initState() {
    super.initState();
    items = Trick.getTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ProductBox(item: items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EachTipsPage(item: items[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
           // Use the navigator to navigate to the selected page
          Navigator.pushNamed(context, pages[index]);
        },
          pages: pages,
      ),
    );
  }
}

class EachTipsPage extends StatefulWidget {
  EachTipsPage({Key? key, required this.item}) : super(key: key);
  final Trick item;

  @override
  _EachTipsPageState createState() => _EachTipsPageState();
}

class _EachTipsPageState extends State<EachTipsPage> {
  int _selectedIndex = 0;
  final List<String> pages = [
    RoutePaths.record,
    RoutePaths.clinic,
    RoutePaths.home,
    RoutePaths.guide,
    RoutePaths.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      25), 
                  image: DecorationImage(
                    image: AssetImage("appimages/" + widget.item.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Description 2
                      _buildBoldText("", widget.item.description2),

                      // Image
                      //_buildBoldText("Image:", widget.item.image),

                      // Context
                      _buildBoldText("Context :", widget.item.context),

                      // Age
                      _buildBoldText("Age :", widget.item.age),

                      // Personality
                      _buildBoldText("Personality :", widget.item.personality),

                      // Breed
                      _buildBoldText("Breed :", widget.item.breed),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
           // Use the navigator to navigate to the selected page
          Navigator.pushNamed(context, pages[index]);
        },
          pages: pages,
      ),
    );
  }

  Widget _buildBoldText(String label, String text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: label + " ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: text), // text is normal
        ],
      ),
    );
  }
}

Widget _buildDescriptionWithBoldWords(String description2) {
  // List of words to be bolded
  List<String> boldWords = ["Context", "Age", "Personality", "Breed"];

  // Splitting the description into words
  List<String> words = description2.split(' ');

  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black),
      children: [
        for (String word in words)
          TextSpan(
            text: boldWords.contains(word) ? word + ' ' : word + ' ',
            style: TextStyle(
              fontWeight: boldWords.contains(word)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
      ],
    ),
  );
}

class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.item}) : super(key: key);
  final Trick item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
          8.0), // Add padding to create space between boxes
      child: Center(
        child: SizedBox(
          width: 380,
          height: 330,
          child: Card(
            elevation: 4, // Set elevation to add a shadow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    "appimages/" + this.item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start, //text to left
                    children: <Widget>[
                      Text(
                        this.item.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(this.item.description),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const BottomNavBar({
//     required this.selectedIndex,
//     required this.onItemTapped,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Color.fromARGB(40, 35, 0, 76),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//         child: BottomNavigationBar(
//           items: [
//             // Record
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: "Record",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.calendar_month_outlined),
//                 ),
//               ),
//             ),
//             // Clinic
//             BottomNavigationBarItem(
//               icon: Icon(Icons.location_on_outlined),
//               label: "Clinic",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.location_on_outlined),
//                 ),
//               ),
//             ),
//             // Home
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: "Home",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.home_outlined),
//                 ),
//               ),
//             ),
//             // Guide
//             BottomNavigationBarItem(
//               icon: Icon(Icons.book_outlined),
//               label: "Guide",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.book_outlined),
//                 ),
//               ),
//             ),
//             // Profile
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline_rounded),
//               label: "Profile",
//               activeIcon: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 160, 138),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 75, 173),
//                       blurRadius: 12.0,
//                       spreadRadius: 2.29,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Icon(Icons.person_outline_rounded),
//                 ),
//               ),
//             ),
//           ],
//           currentIndex: selectedIndex,
//           unselectedItemColor: Color.fromARGB(255, 0, 74, 173),
//           showUnselectedLabels: true,
//           selectedItemColor: Color.fromARGB(255, 0, 74, 173),
//           showSelectedLabels: false,
//           onTap: onItemTapped,
//           type: BottomNavigationBarType.fixed,
//           unselectedFontSize: 14,
//         ),
//       ),
//     );
//   }
// }
