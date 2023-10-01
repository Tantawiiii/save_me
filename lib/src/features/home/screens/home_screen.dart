import 'package:flutter/material.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/src/features/home/screens/add_profile_screen.dart';

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
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image(
                image: AssetImage('assets/images/logowithnobg.png'),
                height: 18,
                width: 80,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_rounded,
                color: Colors.indigo,
              ),
              title: const Text(
                Strings.txtItemHomeMenu,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.login,
                color: Colors.red,
              ),
              title: const Text(
                Strings.txtItemLogoutMenu,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15.0),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>   const AddProfile()),
                      );
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
                            Strings.txtCanAddProfile,
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
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 570,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
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
                child: const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward_sharp),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          Strings.txtStartAddProfile,
                          style: TextStyle(
                            fontSize: 16,
                            // fontFamily: Settings.getFontFamilyCairo(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
