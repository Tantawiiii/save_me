import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../utils/strings/Language.dart';
import '../../internet/no_internet.dart';
import '../widget/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() async {
    await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? const NoInternet()
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 12,
                    shadowColor: Colors.black45,
                    title: Image.asset(
                      'assets/images/logo_save_me.png',
                      fit: BoxFit.cover,
                      height: 16,
                      width: 100,
                    ),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
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
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // Close the loading indicator dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          });
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child:
                              currentLang == "EN" ? englishIcon : deutschIcon,
                        ),
                      ),
                    ],
                    leading: null,
                    //iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  body: const RegisterForm(),
                );
        });
  }

  changeLanguage(lang) async {
    if (SaveMe.getLocal(context).languageCode == 'de') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "EN");

      Language.instance.setLanguage("EN");
      currentLang = "EN";
      setState(() {});
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
