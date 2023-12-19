import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../utils/constants/colors_code.dart';
import '../../../utils/strings/Language.dart';
import '../widget/login_form.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //internet Connection
  // bool isOnline = true;
  // @override
  // void initState() {
  //   super.initState();
  //   // Listen to internet status changes
  //   internetStatusController.stream.listen((bool online) {
  //     setState(() {
  //       isOnline = online;
  //     });
  //   });
  //
  //   // Initialize the UI with the current internet status
  //   checkInternetStatus();
  // }
  // void _onStatusChange(bool online) {
  //   setState(() {
  //     isOnline = online;
  //   });
  // }
  String currentLang = "";
  SvgPicture englishIcon = SvgPicture.asset(
    "assets/images/icons/circ_english.svg",
    width: 24,
    height: 24,
  );

  SvgPicture deutschIcon = SvgPicture.asset(
    'assets/images/icons/cir_deutsch.svg',
    // Replace with the path to your first SVG file
    height: 24,
    width: 24,
  );

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 12,
          backgroundColor: Colors.white,
          shadowColor: Colors.black45,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Image.asset(
            'assets/images/logo_save_me.png',
            fit: BoxFit.cover,
            height: 16,
            width: 100,
          ),
          centerTitle: false,
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'English',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/circ_english.svg',
                          // Replace with the path to your first SVG file
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Deutsch',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/cir_deutsch.svg',
                          // Replace with the path to your first SVG file
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text('Deutsch'),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (String value) {
                // Show loading indicator
                setState(() {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    // Prevent dismissing the dialog by tapping outside
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  // Handle item selection
                  if (value == 'English') {
                    setState(() {
                      changeLanguage("en");
                    });
                  } else if (value == 'Deutsch') {
                    // Handle icon2 selection
                    setState(() {
                      changeLanguage("de");

                    });
                  }

                });
                // Simulate an asynchronous operation
                Future.delayed(const Duration(milliseconds: 1000), () {
                  // Close the loading indicator dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );

                });
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child:  currentLang == "EN" ? englishIcon : deutschIcon ,
              ),
            ),
          ],
        ),
        body: const Center(
          child: LoginForm(),
        ),
      ),
    );
  }

  changeLanguage(lang) async {
    if (SaveMe.getLocal(context).languageCode == 'de') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "EN");

      Language.instance.setLanguage("EN");
      currentLang = "EN";
      setState(() {

      });
      Locale newLocale = const Locale('en');
      SaveMe.setLocale(context, newLocale);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "DE");

      Language.instance.setLanguage("DE");
      currentLang = "DE";
      setState(() {});
      Locale newLocale = const Locale('de');
      SaveMe.setLocale(context, newLocale);
    }

    // setState(() {
    //   //EasyLoading.showSuccess("Changed");
    //   Phoenix.rebirth(context);
    // });
  }
}

/**
 * isOnline
    ? const LoginForm()
    : NoInternet(
    onRefresh: () {
    refreshInternetStatus();
    },
    ),
 */
