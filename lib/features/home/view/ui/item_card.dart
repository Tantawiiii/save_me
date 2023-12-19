import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/utils/strings/Language.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';

import 'info_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoScreen(
                    profileInfo: profileInfo,
                  ),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 340,
        decoration: const BoxDecoration(color: Colors.white),
        child: Card(
          elevation: 2,
          shadowColor: ColorsCode.grayColor,
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
                    const SizedBox(
                      height: 26,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child:
                      profileInfo.photoUrl == null ?
                      Image.asset(
                        'assets/images/image.png',
                        width: 135,
                        height: 145,
                        fit: BoxFit.cover,
                      )
                          :    Image.network(
                        profileInfo.photoUrl!,
                        width: 135,
                        height: 145,
                        fit: BoxFit.cover,
                      )
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      profileInfo.name!,
                      style: TextStyle(
                        color: ColorsCode.grayColor100,
                        fontSize: 14,
                        fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      Language.instance.txtCreateData() +
                          profileInfo.createdDate!,
                      style: TextStyle(
                        color: ColorsCode.grayColor100,
                        fontSize: 10,
                        fontFamily: Fonts.getFontFamilyTitillRegular(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 120,
                height: 40,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: ColorsCode.purpleColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    profileInfo.profileType!,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
