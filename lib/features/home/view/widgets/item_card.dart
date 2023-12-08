import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/view/widgets/info_screen.dart';

import '../../../../constants/strings/Strings_en.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

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
      body: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoScreen()),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(25),
          width: 180,
          height: 280,
          decoration: const BoxDecoration(color: Colors.white),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              //set border radius more than 50% of height and width to make circle
            ),
            color: Colors.white,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20,),
                      Image.asset(
                        'assets/images/image.png',
                        width: 133,
                        height: 160,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Adam Doe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        ),
                      ),
        
                      const SizedBox(
                        height: 8,
                      ),
        
                      Text(
                        'creation data 6/12/2023',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        ),
                      ),
        
        
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 35,
                  alignment: Alignment.topRight,
                  child: Center(
                    child: Text('Kid',style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                  decoration: BoxDecoration(
                    color: ColorsCode.purpleColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
        
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
