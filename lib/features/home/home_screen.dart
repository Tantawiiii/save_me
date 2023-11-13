import 'package:flutter/material.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/pages/home_page.dart';
import 'package:save_me/features/home/pages/location_page.dart';
import 'package:save_me/features/home/pages/profile_page.dart';
import 'package:save_me/features/home/pages/setting_page.dart';
import 'package:save_me/features/home/widget/action_button.dart';
import 'package:save_me/features/home/widget/expandable_fab.dart';


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

  void toggleCircularMenu() {
    setState(() {
      isCircularMenuOpen = !isCircularMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsCode.purpleColorBright,
          onPressed: () {

            // Handle the main FAB button press.
            // You can implement a default action here.
          },
          child: Icon(fabIcon),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomSheet: isCircularMenuOpen ? CircularMenu(
      //     alignment: Alignment.center,
      //     startingAngleInRadian: 0,
      //     endingAngleInRadian: 3 * 3.1416 / 2,
      //     reverseCurve: Curves.bounceIn,
      //   items: [
      //     CircularMenuItem(
      //       icon: Icons.add,
      //       onTap: () {
      //         // Implement action for the first circular menu item
      //       },
      //     ),
      //     CircularMenuItem(
      //       icon: Icons.edit,
      //       onTap: () {
      //         // Implement action for the second circular menu item
      //       },
      //     ),
      //     CircularMenuItem(
      //       icon: Icons.delete,
      //       onTap: () {
      //         // Implement action for the third circular menu item
      //       },
      //     ),
      //   ],
      // ) : null,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 85,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                        currentScreen = screens[currentTab];
                      });
                    },
                    color: currentTab == 0
                        ? ColorsCode.purpleColorBright
                        : ColorsCode.grayColor300,
                  ),
                  Text(
                    Strings.txtHomeTab,
                    style: TextStyle(
                        color: currentTab == 0
                            ? ColorsCode.purpleColorBright
                            : ColorsCode.grayColor300,
                        fontSize: 12,
                        fontFamily: Fonts.getFontFamilyTitillRegular()),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person),
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
                        fontFamily: Fonts.getFontFamilyTitillRegular()),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.my_location_outlined),
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
                        fontFamily: Fonts.getFontFamilyTitillRegular()),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
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
                        fontFamily: Fonts.getFontFamilyTitillRegular()),
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
