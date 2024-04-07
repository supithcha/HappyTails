import 'package:flutter/material.dart';
import 'package:happytails/bottom_nav_bar.dart';

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
    List<Trick> tipsItem = <Trick>[];
    tipsItem.add(Trick(
        "Factor to consider when interpreting your dog's behaviour",
        "Whilst looking out for the behaviours above will help you understand what your dog",
        "Whilst looking out for the behaviours above will help you understand what your dog is feeling, here are some factors to bear in mind:",
        "dog.png",
        "It's essential to consider the specific situation and what's normal for your dog when reading their body language. What might be relaxed behaviour in a home environment can mean something different in a public setting.",
        "Puppies and older dogs will behave very differently due to their stage of development and age-related changes. Puppies are likely to be more energetic and playful, while older dogs tend to be calmer.",
        "Just like people, dogs have their own personalities that influence their behaviour. Some dogs may be more outgoing and confident, while others may be more timid and anxious.",
        "Different dog breeds can have certain behaviours due to selective breeding. For example, herding breeds, such as sheepdogs, may like to herd other animals. However, this does not mean all dogs of a breed will show the same behaviour, as environment, learning and individual personality will also affect how they behave. "));
    tipsItem.add(Trick(
        "Pet in Condos: 5 Key considerations",
        "Pet owners look for a condo to live in,they look for pet-friendly building",
        "Pet owners look for a condo to live in, they look for pet-friendly buildings. So when a building prohibits pets you reduce your prospective owners and tenants who want to live there. Your condo may also face criticism as it may be considered discriminatory to prohibit pets. ",
        "cat.png",
        "Share rules around pets in condos",
        "Make your condo pet-friendly",
        "Just like people, dogs have their own personalities that influence their behaviour. Some dogs may be more outgoing and confident, while others may be more timid and anxious.",
        "Different dog breeds can have certain behaviours due to selective breeding. For example, herding breeds, such as sheepdogs, may like to herd other animals. However, this does not mean all dogs of a breed will show the same behaviour, as environment, learning and individual personality will also affect how they behave. "));
    return tipsItem;
  }
}

class TipsPage extends StatefulWidget {
  TipsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  late List<Trick> tips;

  @override
  void initState() {
    super.initState();
    tips = Trick.getTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  'assets/logo/logo-white.png',
                  width: 60,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips and Tricks',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade200,
                  Colors.indigo.shade400,
                  Colors.indigo.shade700,
                  Colors.indigo.shade900,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ProductBox(item: tips[index]),
            onTap: () {
              print('Selected tip: ${tips[index]}, index = $index');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EachTipsPage(item: tips[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 3, // Initial selected index
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200, // Reduce the height of the image container
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: AssetImage("assets/tt/" + widget.item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Add spacing between image and text
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Description 2
                    _buildBoldText("", widget.item.description2),
                    SizedBox(height: 20),
                    // Context
                    _buildBoldText("Context :", widget.item.context),
                    SizedBox(height: 20),
                    // Age
                    _buildBoldText("Age :", widget.item.age),
                    SizedBox(height: 20),
                    // Personality
                    _buildBoldText("Personality :", widget.item.personality),
                    SizedBox(height: 20),
                    // Breed
                    _buildBoldText("Breed :", widget.item.breed),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 3, // Initial selected index
      ),
    );
  }

  // Widget _buildBoldText(String label, String text) {
  //   return RichText(
  //     text: TextSpan(
  //       children: [
  //         TextSpan(
  //           text: label + " ",
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         TextSpan(text: text), // text is normal
  //       ],
  //     ),
  //   );
  // }
  Widget _buildBoldText(String label, String text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black, // Set the default text color
          fontSize: 16, // Set the default font size
        ),
        children: [
          TextSpan(
            text: label + '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text,
          ),
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
            text: boldWords.contains(word.trim()) ? '$word ' : '$word ',
            style: TextStyle(
              fontWeight: boldWords.contains(word.trim())
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        // TextSpan(
        //   text: boldWords.contains(word) ? '$word ' : '$word ',
        //   style: TextStyle(
        //     fontWeight: boldWords.contains(word)
        //         ? FontWeight.bold
        //         : FontWeight.normal,
        //   ),
        // ),
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
                    "assets/tt/" + this.item.image,
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
