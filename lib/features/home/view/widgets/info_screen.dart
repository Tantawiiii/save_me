

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/colors_code.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/strings/Strings_en.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
                StringsEn.txtAppBarHome,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                  fontSize: 16,
                ),
              ),
              Text(
                StringsEn.txtAppBarWelcome,
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
        body:  Card(
          elevation: 8,
          margin: const EdgeInsets.only(top: 20,right: 15,left: 15,bottom: 20),
          child: Container(
            padding: const EdgeInsets.only(top: 20,right: 15,left: 15,),
            margin: const EdgeInsets.only(top: 20,right: 15,left: 15,),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: ColorsCode.whiteColor,
              borderRadius:  BorderRadius.circular(8),

            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/kid_circ.png",),
                        Text('Hey I am    Adam Smith',style: TextStyle(
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        ),)
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Characteristics',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold()
                        ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Behaviour',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Special Characteristics',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 8,),

                        Text('Allergies',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Diet',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Diseases',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold()
                          ) ,
                        ),
                        const SizedBox(height: 8,),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular()
                          ) ,
                        ),
                        const SizedBox(height: 100,),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
