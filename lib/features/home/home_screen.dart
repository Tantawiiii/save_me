import 'dart:math';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/cards/add_profile_screen.dart';
import 'package:save_me/features/home/pages/home_page.dart';
import 'package:save_me/features/home/pages/location_page.dart';
import 'package:save_me/features/home/pages/profile_page.dart';
import 'package:save_me/features/home/pages/setting_page.dart';
import 'package:save_me/features/home/widgets/expandable_fab.dart';

import 'widgets/action_botton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String id = 'HomeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const Profile(),
    const Location(),
    const Setting(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  // current tab in Bottom Navigation
  Widget currentScreen = const HomeScreen();
  bool isCircularMenuOpen = false;
  IconData fabIcon = Icons.add; // Initial FAB icon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Column(
          children: [
            Text(
              Strings.txtAppBarHome,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                fontSize: 16,
              ),
            ),
            Text(
              Strings.txtAppBarWelcome,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                fontSize: 10,
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            padding: const EdgeInsets.only(right: 12),
            onPressed: () {},
          ),
        ],
        elevation: 5,
        shadowColor: Colors.black12,
        leading: const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Image(
            image: AssetImage('assets/images/logowithnobg.png'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      // Make the Floating Action Button to a fixed location when use Keyboard navigation
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: const SizedBox(
        width: 85,
        height: 85,
        //child: MyExpandableFab()
        child: CircleFab(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 14,
        notchMargin: 10,
        shadowColor: ColorsCode.blackColor100,
        child: Container(
          height: 85,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home_rounded),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                          currentScreen = screens[currentTab];
                        });
                      },
                      color: currentTab == 0
                          ? ColorsCode.purpleColor
                          : ColorsCode.grayColor300,
                    ),
                    Text(
                      Strings.txtHomeTab,
                      style: TextStyle(
                          color: currentTab == 0
                              ? ColorsCode.purpleColorBright
                              : ColorsCode.grayColor300,
                          fontSize: 12,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person_2),
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                          currentScreen = screens[currentTab];
                        });
                      },
                      color: currentTab == 1
                          ? ColorsCode.purpleColorBright
                          : ColorsCode.grayColor300,
                    ),
                    Text(
                      Strings.txtProfileTab,
                      style: TextStyle(
                          color: currentTab == 1
                              ? ColorsCode.purpleColorBright
                              : ColorsCode.grayColor300,
                          fontSize: 12,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.my_location_rounded),
                      onPressed: () {
                        setState(() {
                          currentTab = 2;
                          currentScreen = screens[currentTab];
                        });
                      },
                      color: currentTab == 2
                          ? ColorsCode.purpleColorBright
                          : ColorsCode.grayColor300,
                    ),
                    Text(
                      Strings.txtLocationTab,
                      style: TextStyle(
                          color: currentTab == 2
                              ? ColorsCode.purpleColorBright
                              : ColorsCode.grayColor300,
                          fontSize: 12,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        setState(() {
                          currentTab = 3;
                          currentScreen = screens[currentTab];
                        });
                      },
                      color: currentTab == 3
                          ? ColorsCode.purpleColorBright
                          : ColorsCode.grayColor300,
                    ),
                    Text(
                      Strings.txtSettingsTab,
                      style: TextStyle(
                          color: currentTab == 3
                              ? ColorsCode.purpleColorBright
                              : ColorsCode.grayColor300,
                          fontSize: 12,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// circular menu In Floating Button

class CircleFab extends StatelessWidget {


  const CircleFab({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
        // menu alignment
        alignment: Alignment.bottomCenter,
        startingAngleInRadian: 1.2 * pi,
        endingAngleInRadian: 1.8 * pi,
        // menu radius
        radius: 130,
        // animation duration
        animationDuration: const Duration(milliseconds: 400),
        // animation curve in forward
        curve: Curves.bounceOut,
        // animation curve in reverse
        reverseCurve: Curves.fastOutSlowIn,
        // toggle button callback
        toggleButtonOnPressed: () {
          //callback
        },
        toggleButtonBoxShadow: const [
          BoxShadow(
            color: Colors.purpleAccent,
            blurRadius: 25,
          ),
        ],
        toggleButtonColor: ColorsCode.purpleColor,
        toggleButtonIconColor: Colors.white,
        toggleButtonSize: 42,
        toggleButtonPadding: 10.0,
        items: [
          CircularMenuItem(
              icon: Icons.search,
              color: Colors.purple.shade300,
              onTap: () {
                //callback
                _navigateToScreen(context,  SearchScreen());
              }),
          CircularMenuItem(
              //enableBadge: true,
              icon: Icons.settings,
              color: Colors.purple.shade300,
              onTap: () {
                //callback
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AddProfile()),
                // );
                print('badge on circular menu item');
              }),
          CircularMenuItem(
              icon: Icons.star,
              color: Colors.purple.shade300,
              onTap: () {
                //callback
                print('badge on circular menu item');
              }),
          CircularMenuItem(
              icon: Icons.pages,
              color: Colors.purple.shade300,
              onTap: () {
                //callback
                print('badge on circular menu item');
              }),
          CircularMenuItem(
              icon: Icons.hail_rounded,
              color: Colors.purple.shade300,
              onTap: () {

                setState(){

                }
                //callbak
              }),
        ]);
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
      ),
      body: const Center(
        child: Text('This is the Search Screen'),
      ),
    );
  }
}


class MyExpandableFab extends StatelessWidget {
  const MyExpandableFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 112.0,
      children: [
        ActionButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            print('person');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            print('settings');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            print('add');
          },
        ),
      ],
    );
  }
}
class ExpandableFabController with ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
