import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:  ColorScheme(
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
          elevation:12,
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
          margin: const EdgeInsets.only(right: 8,left: 8),
          child: SpeedDial(
            backgroundColor: ColorsCode.purpleColor, //background color of button
            foregroundColor: ColorsCode.whiteColor, //font color, icon color in button
            activeBackgroundColor: Colors.black, //background color when menu is expanded
            activeForegroundColor: Colors.white,
            direction: SpeedDialDirection.up,
            visible: true,
            closeManually: false,
            curve: Curves.bounceOut,
            overlayColor: Colors.black,
            overlayOpacity: 0.2,
            spaceBetweenChildren: 4,
            spacing: 5,
            onOpen: () => print('OPENING DIAL'), // action when menu opens
            onClose: () => print('DIAL CLOSED'), //action when menu closes
            buttonSize: const Size(75.0, 75.0),
            childrenButtonSize: const Size(60.0, 60.0),
            childMargin: const EdgeInsets.all(20),
            mini: false,
            elevation: 8.0, //shadow elevation of button
            shape:  CircleBorder(), //shape of button
            children: [
              SpeedDialChild( //speed dial child
                child: IconButton(
                  onPressed: () {  }, 
                  icon: SvgPicture.asset("assets/images/Kids_black.svg",width: 30,height: 30,),
                  
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () => print('FIRST CHILD'),
                onLongPress: () => print('FIRST CHILD LONG PRESS'),
                shape: const CircleBorder(),
              ),
              SpeedDialChild(
                child: IconButton(
                  onPressed: () {  },
                  icon: SvgPicture.asset("assets/images/Pets_black.svg",width: 30,height: 30,),

                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () => print('SECOND CHILD'),
                onLongPress: () => print('SECOND CHILD LONG PRESS'),
                shape: const CircleBorder(),
              ),
              SpeedDialChild(
                child: IconButton(
                  onPressed: () {  },
                  icon: SvgPicture.asset("assets/images/Disabled_black.svg",width: 30,height: 30,),

                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () => print('THIRD CHILD'),
                onLongPress: () => print('THIRD CHILD LONG PRESS'),
                shape: const CircleBorder(),
              ),
              SpeedDialChild( //speed dial child
                child: IconButton(
                  onPressed: () {  },
                  icon: SvgPicture.asset("assets/images/Seniors_black.svg",width: 30,height: 30,),

                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () => print('FIRST CHILD'),
                onLongPress: () => print('FIRST CHILD LONG PRESS'),
                shape: const CircleBorder(),
              ),
              SpeedDialChild( //speed dial child
                child: IconButton(
                  onPressed: () {  },
                  icon: SvgPicture.asset("assets/images/Item_black.svg",width: 30,height: 30,),

                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () => print('FIRST CHILD'),
                onLongPress: () => print('FIRST CHILD LONG PRESS'),
                shape: const CircleBorder(),
              ),

            ],
            activeChild:SvgPicture.asset(
              'assets/images/close.svg',
              color: Colors.white,
              width: 24,
              height: 24,
            ),

            child: SvgPicture.asset("assets/images/plus.svg",color: Colors.white,),
          ),
        ) ,

        //to create a circle menu
        // const SizedBox(
        //   width: 95,
        //   height: 95,
        //   //child: MyExpandableFab()
        //   child: CircleFab(),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: SizedBox(
          height: 95,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            elevation: 14,
            notchMargin: 0,
            shadowColor: ColorsCode.blackColor100,
            child: Container(
              padding: const EdgeInsets.only(left: 6, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                            "assets/images/home.svg",
                            color: currentTab == 0
                        ? ColorsCode.purpleColor
                            : ColorsCode.grayColor300,
                            semanticsLabel: 'Label'
                        ),
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
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32,),
                  Column(
                    children: [
                      IconButton(

                        icon: SvgPicture.asset(
                            "assets/images/user_fill.svg",
                            color: currentTab == 1
                                ? ColorsCode.purpleColor
                                : ColorsCode.grayColor300,
                            semanticsLabel: 'Label'
                        ),
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
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32,),
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
                            ? ColorsCode.purpleColorBright
                            : ColorsCode.grayColor300,
                      ),
                      Text(
                        Strings.txtLocationTab,
                        style: TextStyle(
                            color: currentTab == 2
                                ? ColorsCode.purpleColorBright
                                : ColorsCode.grayColor300,
                            fontSize: 13,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32,),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings,size: 28,),
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
  void displayMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
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


/**
 *
 * // circular menu In Floating Button
    class CircleFab extends StatelessWidget {

    const CircleFab({super.key});

    @override
    Widget build(BuildContext context) {
    return CircularMenu(
    // menu alignment
    alignment: Alignment.bottomRight,
    startingAngleInRadian: 1.2 * pi,
    endingAngleInRadian: 1.8 * pi,
    // menu radius
    radius: 130,
    // animation duration
    animationDuration: const Duration(milliseconds: 600),
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
    blurRadius: 15,
    ),
    ],
    toggleButtonColor: ColorsCode.purpleColor,
    toggleButtonIconColor: Colors.white,
    toggleButtonSize: 52,
    toggleButtonPadding: 12.0,
    toggleButtonMargin: 0,
    //toggleButtonIcon: Icons.menu, // Change the toggle button icon here
    items: [
    CircularMenuItem(
    icon: Icons.search,
    color: Colors.purple.shade300,
    onTap: () {
    //callback
    /// _navigateToScreen(context,  SearchScreen());
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

 *
 *


 * FabCircularMenu(
    alignment: Alignment.bottomRight,
    ringColor: Colors.blue.withAlpha(25),
    ringDiameter: 500.0,
    ringWidth: 150.0,
    fabSize: 90.0,
    fabElevation: 8.0,
    fabIconBorder: CircleBorder(),
    children: <Widget> [
    RawMaterialButton(
    onPressed: () {
    displayMessage(context, 'Home Clicked');
    },
    elevation: 10.0,
    fillColor: Colors.green,
    child: Icon(
    Icons.home,
    size: 30.0,
    ),
    padding: EdgeInsets.all(15.0),
    shape: CircleBorder(),
    ),
    RawMaterialButton(
    onPressed: () {
    displayMessage(context, 'Search Clicked');
    },
    elevation: 10.0,
    fillColor: Colors.orange,
    child: Icon(
    Icons.search,
    size: 30.0,
    ),
    padding: EdgeInsets.all(15.0),
    shape: CircleBorder(),
    ),
    CircleAvatar(
    radius: 30,
    backgroundColor: Colors.purple,
    child: IconButton(
    icon: Icon(
    Icons.settings,
    size: 30,
    ),
    onPressed: () {
    displayMessage(context, 'Setting Clicked');
    }),
    ),
    IconButton(
    icon: Icon(
    Icons.star,
    color: Colors.brown,
    size: 40,
    ),
    onPressed: () {
    displayMessage(context, 'Favorite Clicked');
    }),
    ],
    ),
 */