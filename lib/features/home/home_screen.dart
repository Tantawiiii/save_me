// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';


import 'package:save_me/features/home/view/cards/add_disabled_profile.dart';
import 'package:save_me/features/home/view/cards/add_item_profile.dart';
import 'package:save_me/features/home/view/cards/add_kid_profile.dart';
import 'package:save_me/features/home/view/cards/add_pet_profile.dart';
import 'package:save_me/features/home/view/cards/add_senior_profile.dart';
import 'package:save_me/features/home/view/pages/home_page.dart';
import 'package:save_me/features/home/view/pages/location/location_page.dart';
import 'package:save_me/features/home/view/pages/profile_page.dart';
import 'package:save_me/features/home/view/pages/setting_page.dart';

import 'package:auto_route/auto_route.dart';

import '../../utils/constants/colors_code.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/strings/Language.dart';


@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  static String id = 'HomeScreen';
  static final GlobalKey<_HomeScreenState> homePageKey = GlobalKey<_HomeScreenState>();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GlobalKey for accessing the SpeedDial widget
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Method to open the SpeedDial
  void openSpeedDial() {
    _scaffoldKey.currentState!.openDrawer();
  }

  int currentTab = 0;
  final List<Widget> screens = [
    const Home(),
    const Profile(),
    const Location(),
    const Setting(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  // current tab in Bottom Navigation
  Widget currentScreen = const Home();
  bool isCircularMenuOpen = false;

// Default SVG icon path
  String mainIconPath = 'assets/images/plus.svg';
  Color mainBackColor = ColorsCode.purpleColor;
  Color isActiveIconColor = ColorsCode.purpleColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorsCode.whiteColor,
          onPrimary: ColorsCode.blackColor,
          secondary: Colors.white,
          onSecondary: Colors.grey,
          background: Colors.white,
          onBackground: Colors.grey,
          error: Colors.red,
          onError: ColorsCode.grayColor,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Column(
            children: [
              Text(
                Language.instance.txtAppBarHome(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                  fontSize: 16,
                ),
              ),
              Text(
                Language.instance.txtAppBarWelcome(),
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
          elevation: 12,
          shadowColor: Colors.black45,
          leading: const Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Image(
              image: AssetImage('assets/images/logowithnobg.png'),
            ),
          ),
          centerTitle: true,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        // Make the Floating Action Button to a fixed location when use Keyboard navigation
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(right: 8, left: 8),
          child: SpeedDial(
            backgroundColor: mainBackColor,
            //foregroundColor: ColorsCode.blackColor,
            activeBackgroundColor: Colors.black,
            activeForegroundColor: Colors.white,
            direction: SpeedDialDirection.up,
            visible:true,
            closeManually: false,
            curve: Curves.bounceOut,
            overlayColor: Colors.black,
            overlayOpacity: 0.2,
            spaceBetweenChildren: 4,
            spacing: 5,
            buttonSize: const Size(75.0, 75.0),
            childrenButtonSize: const Size(60.0, 60.0),
            childMargin: const EdgeInsets.all(20),
            mini: false,
            elevation: 8.0,
            //shadow elevation of button
            shape: const CircleBorder(),
            //shape of button
            children: [
              SpeedDialChild(
                child: SvgPicture.asset(
                  "assets/images/Kids_black.svg",
                  width: 30,
                  height: 30,
                  //color: Colors.black,
                ),
                // backgroundColor: Colors.white,
                onTap: ()  {
                  onChildTapped(
                    "assets/images/kids.svg",
                    Colors.white,
                  );
                  setState(() {
                    currentScreen = const AddKidProfile();
                    isActiveIconColor = ColorsCode.grayColor300;
                  });
                // Close the SpeedDial after the button is pressed
               // Provider.of<SpeedDialProvider>(context, listen: false).toggleDial();
                },
                shape: const CircleBorder(),

              ),
              SpeedDialChild(
                child: SvgPicture.asset(
                  "assets/images/Seniors_black.svg",
                  width: 30,
                  height: 30,
                  //color: Colors.black,
                ),
                // backgroundColor: Colors.white,
                onTap: () => {
                  onChildTapped(
                    "assets/images/Seniors.svg",
                    Colors.white,
                  ),
                  setState(() {
                    currentScreen = const AddSeniorProfile();
                    isActiveIconColor = ColorsCode.grayColor300;
                  }),

                  // Close the SpeedDial after the button is pressed
                  _scaffoldKey.currentState!.openDrawer(),
                },
                shape: const CircleBorder(),
              ),
              SpeedDialChild(
                child: SvgPicture.asset(
                    "assets/images/Disabled_black.svg",
                    width: 30,
                    height: 30,
                  ),
                onTap: () => {
                  onChildTapped(
                    "assets/images/Disabled.svg",
                    Colors.white,
                  ),
                  setState(() {
                    currentScreen = const AddDisabledProfile();

                  }),

                  // Close the SpeedDial after the button is pressed
                  _scaffoldKey.currentState!.openDrawer(),
                },

                shape: const CircleBorder(),
              ),
              SpeedDialChild(
                child: SvgPicture.asset(
                  "assets/images/Pets_black.svg",
                  width: 30,
                  height: 30,
                ),
                onTap: () => {
                  onChildTapped(
                    "assets/images/Pets.svg",
                    Colors.white,
                  ),
                  setState(() {
                    currentScreen = const AddPetProfile();
                    isActiveIconColor = ColorsCode.grayColor300;
                  }),

                  // Close the SpeedDial after the button is pressed
                  _scaffoldKey.currentState!.openDrawer(),
                },
                shape: const CircleBorder(),
              ),
              SpeedDialChild(
                //speed dial child
                child: SvgPicture.asset(
                    "assets/images/Item_black.svg",
                    width: 30,
                    height: 30,
                  ),
                onTap: () => {
                  onChildTapped(
                    "assets/images/Item.svg",
                    Colors.white,
                  ),
                  setState(() {
                    currentScreen = const AddItemProfile();

                  }),
                isActiveIconColor = ColorsCode.grayColor300,
                  // Close the SpeedDial after the button is pressed
                  _scaffoldKey.currentState!.openDrawer(),
                },
                shape: const CircleBorder(),
              ),
            ],
            activeChild: SvgPicture.asset(
              'assets/images/close.svg',
              color: Colors.white,
              width: 24,
              height: 24,
            ),
            child: SvgPicture.asset(
              mainIconPath,
              width: 18,
              height: 18,
              //color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: SizedBox(
          height: 95,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            elevation: 14,
            notchMargin: 0,
            shadowColor: ColorsCode.blackColor100,
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset("assets/images/home.svg",
                            color: currentTab == 0
                                ? isActiveIconColor
                                : ColorsCode.grayColor300,
                            semanticsLabel: 'Label'),
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                            currentScreen = screens[currentTab];
                          });
                        },
                      ),
                      Text(
                        Language.instance.txtHomeTab(),
                        style: TextStyle(
                            color: currentTab == 0
                                ?  isActiveIconColor
                                : ColorsCode.grayColor300,
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                            "assets/images/user_fill.svg",
                            color: currentTab == 1
                                ? isActiveIconColor
                                : ColorsCode.grayColor300,
                            semanticsLabel: 'Label'),
                        onPressed: () {
                          setState(() {
                            currentTab = 1;
                            currentScreen = screens[currentTab];
                            if (currentTab == 1) {
                              isActiveIconColor;
                            }
                          });
                        },
                      ),
                      Text(
                        Language.instance.txtProfileTab(),
                        style: TextStyle(
                            color: currentTab == 1
                                ? isActiveIconColor
                                : ColorsCode.grayColor300,
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.my_location_rounded,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                            currentScreen = screens[currentTab];
                          });
                        },
                        color: currentTab == 2
                            ? isActiveIconColor
                            : ColorsCode.grayColor300,
                      ),
                      Text(
                        Language.instance.txtLocationTab(),
                        style: TextStyle(
                            color: currentTab == 2
                                ? isActiveIconColor
                                : ColorsCode.grayColor300,
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                            currentScreen = screens[currentTab];
                          });
                        },
                        color: currentTab == 3
                            ? isActiveIconColor
                            : ColorsCode.grayColor300,
                      ),
                      Text(
                        Language.instance.txtSettingsTab(),
                        style: TextStyle(
                            color: currentTab == 3
                                ? isActiveIconColor
                                : ColorsCode.grayColor300,
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to handle the tap event for a SpeedDialChild
  void onChildTapped(String newIconPath, Color newBackColor) {
    // Update the mainIconPath to trigger a rebuild
    setState(() {
      mainIconPath = newIconPath;
      mainBackColor = newBackColor;
    });
    if (kDebugMode) {
      print('Child tapped. New main icon path: $newIconPath');
    }
  }
}


/*
* SpinCircleBottomBarHolder(
          bottomNavigationBar: SCBottomBarDetails(
            circleColors: [Colors.white, Colors.orange, Colors.redAccent],
            iconTheme: IconThemeData(color: Colors.black45),
            activeIconTheme: IconThemeData(color: Colors.orange),
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black45,fontSize: 12),
            activeTitleStyle: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
              color: Colors.redAccent,
              icon: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
              elevation: 2
            ),
            elevation: 2.0,
            items: [
              // Suggested count : 4
              SCBottomBarItem(icon: Icons.verified_user, title: "User", onPressed: () {

              }),
              SCBottomBarItem(icon: Icons.supervised_user_circle, title: "Details", onPressed: () {}),
              SCBottomBarItem(icon: Icons.notifications, title: "Notifications", onPressed: () {}),
              SCBottomBarItem(icon: Icons.details, title: "New Data", onPressed: () {}),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(icon: Icon(Icons.add), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondScreen()));
              }),
              SCItem(icon: Icon(Icons.print), onPressed: () {}),
              SCItem(icon: Icon(Icons.map), onPressed: () {}),
            ],
            bnbHeight: 80 // Suggested Height 80
          ),
          child: Container(
            color: Colors.orangeAccent.withAlpha(55),
            child: Center(child: Text("Isn't this Awesome!"),),
          ),
        ),
* */