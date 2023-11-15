import 'dart:math';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/pages/home_page.dart';
import 'package:save_me/features/home/pages/location_page.dart';
import 'package:save_me/features/home/pages/profile_page.dart';
import 'package:save_me/features/home/pages/setting_page.dart';

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
      // Make the Floating Action Button to a fixed location when use Keyboard navigation
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: CircularMenu(
            // menu alignment
            alignment: Alignment.bottomCenter,
            startingAngleInRadian: 1.2 * pi,
            endingAngleInRadian: 1.67 * pi,
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
                  //enableBadge: true,
                  icon: Icons.search,
                  color: Colors.purple.shade300,
                  onTap: () {
                    //callback
                  }),
              CircularMenuItem(
                  //enableBadge: true,
                  icon: Icons.settings,
                  color: Colors.purple.shade300,
                  onTap: () {
                    //callback
                  }),
              CircularMenuItem(
                  icon: Icons.star,
                  color: Colors.purple.shade300,
                  onTap: () {
                    //callback
                  }),
              CircularMenuItem(
                  icon: Icons.pages,
                  color: Colors.purple.shade300,
                  onTap: () {
                    //callback
                  }),
              CircularMenuItem(
                  icon: Icons.hail_rounded,
                  color: Colors.purple.shade300,
                  onTap: () {
                    //callback
                  }),
            ]),
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
              Column(
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
              Column(
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
              const SizedBox(
                width: 70,
              ),
              Column(
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
              Column(
                //mainAxisSize: MainAxisSize.min,
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
            ],
          ),
        ),
      ),
    );
  }
}
