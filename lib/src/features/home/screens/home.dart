import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String id = 'HomeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_save_me.png',
          fit: BoxFit.cover,
          height: 18,
          width: 120,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(22.0),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5), // Add rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  child: Container(
                    width: 90,
                    height: 100,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.add_box),
                    ),
                  ),
                  onTap: () {
                    // Action to add Profile Card
                    print("Tapped on Add Profile");
                  },
                ),
                const Center(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.arrow_back_sharp),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          "You Can Add Profiles \n From Here",
                          style: TextStyle(
                            fontSize: 16,
                            // fontFamily: Settings.getFontFamilyCairo(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height:500,
              padding: const EdgeInsets.all(22.0),
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.8,
                ),
                // Add rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
