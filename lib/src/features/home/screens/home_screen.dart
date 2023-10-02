import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/src/features/home/screens/add_profile_screen.dart';

import '../../../../constants/settings.dart';

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
                width: 70,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_rounded,
                color: Colors.indigo,
              ),
              title:  const Text(
                Strings.txtItemHomeMenu,
                style: TextStyle(
                  fontSize: 16,

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
                  fontSize: 16,
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
              // Check Internet Connection
              // Container(
              //   margin: const EdgeInsets.all(20),
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: StreamBuilder(
              //       stream: Connectivity().onConnectivityChanged,
              //       builder: (context, AsyncSnapshot<ConnectivityResult> snapshot){
              //         print(snapshot.toString());
              //         if(snapshot.hasData){
              //           ConnectivityResult? result = snapshot.data;
              //           if(result == ConnectivityResult.mobile){
              //             // connected a data internet mobile
              //              if (kDebugMode) {
              //                print("MOBILE");
              //              }
              //           } else if (result == ConnectivityResult.wifi){
              //             // Connected with Wifi internet
              //             if (kDebugMode) {
              //               print("WIFI");
              //             }
              //
              //           } else {
              //             // No Internet
              //             noInternet();
              //           }
              //         } else {
              //           // Show Loading..
              //           return loading();
              //         }
              //         return const Text("No widget to build");
              //       },
              //   ),
              // ),

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

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
      ),
    );
  }

  Widget connected(String type){
    return Center(
      child: Text(
        "$type Connected",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.green,
        ),
      ),
    );

  }

  Widget noInternet(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
            'assets/anim/anim_internet.json',
        height: 100,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20,bottom: 10),
          child: const Text(
            "No Internet Connection.",
            style: TextStyle(fontSize: 22),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text(
            "Check your connection, then refresh the page.",
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () async {
            // You can also check the internet connection through this below function as well
            ConnectivityResult result = await Connectivity().checkConnectivity();
            print(result.toString());
          },
          child: const Text("Refresh"),
        ),
      ],
    );
  }
}
