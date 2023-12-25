import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    String svgAssetPath = '';
    String typeCard = '';
    switch (profileInfo.profileType) {
      case "ITEM":
        svgAssetPath = 'assets/images/Item.svg';
        typeCard = "Item profile";
        break;
      case "DISABLED_PERSON":
        svgAssetPath = 'assets/images/Disabled.svg';
        typeCard = "Disabled person profile";
        break;
      case "KID":
        svgAssetPath = 'assets/images/kids.svg';
        typeCard = "Child profile";
        break;
      case "PET":
        svgAssetPath = 'assets/images/Pets.svg';
        typeCard = "Pet profile";
        break;
      case "SENIOR":
        svgAssetPath = 'assets/images/Seniors.svg';
        typeCard = "Senior profile";
        break;
      default:
        svgAssetPath = 'assets/images/Item.svg';
        typeCard = "item profile";
    }

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10.0,
              spreadRadius: 4.0,
            )
          ],
          color: Colors.white,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Card(
              elevation: 0,
              shadowColor: ColorsCode.grayColor,
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 26,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: profileInfo.photoUrl == null
                            ? SvgPicture.asset(
                                svgAssetPath,
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                profileInfo.photoUrl!,
                                width: 130,
                                height: 140,
                                fit: BoxFit.cover,
                              )),
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
            ),
            Container(
              width: 120,
              height: 36,
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
                  typeCard,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
    );
  }
}
