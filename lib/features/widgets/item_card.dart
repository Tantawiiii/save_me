import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_me/features/home/models/profile_info.dart';


import '../../utils/constants/colors_code.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/strings/Strings_en.dart';
import 'info_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.profileInfo});

  final ProfileInfo profileInfo ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)
            =>  InfoScreen(profileInfo: profileInfo,)),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(25),
          width: 156,
          height: 217,
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
                        width: 124,
                        height: 122,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        profileInfo.name!,
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
                        profileInfo.createdDate!,
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
                  height: 31,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: ColorsCode.purpleColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
        
                  ),
                  child:  Center(
                    child: Text(
                      profileInfo.profileType!
                      ,style: const TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
