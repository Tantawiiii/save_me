import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/widgets/delete_dialog.dart';
import 'package:save_me/features/widgets/share_dialog.dart';
import 'package:save_me/utils/strings/Language.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

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
              Language.instance.txtAppBarHome() + profileInfo.name!,
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
        elevation: 8,
        shadowColor: Colors.black45,
        // leading: const Padding(
        //   padding: EdgeInsets.only(left: 3.0),
        //   child: Image(
        //     image: AssetImage('assets/images/logowithnobg.png'),
        //   ),
        // ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<ProfileInfo>>(
          future: getPublicProfileId(),
          builder: (context, snapshot) {
            if (snapshot.data?.isNotEmpty ?? true) {
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(
                    top: 24, right: 20, left: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child:
                                SvgPicture.asset('assets/images/icons/eye.svg'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          SvgPicture.asset('assets/images/icons/edit.svg'),
                          const SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: () {
                              shareDialog(context, onPressed: () {});
                            },
                            child: SvgPicture.asset(
                                'assets/images/icons/share.svg'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Bounce(
                            onPressed: () {},
                            duration: const Duration(milliseconds: 400),
                            child: InkWell(
                              onTap: () {
                                deleteDialog(context, onPressed: () {});
                              },
                              child: SvgPicture.asset(
                                  'assets/images/icons/delete.svg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 24,
                        children: [
                          Container(
                            width: 156,
                            height: 250,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 15, top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: ColorsCode.purpleColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/kid_circ.png",
                                ),
                                Text(
                                  profileInfo.name!,
                                  style: TextStyle(
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold(),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  Language.instance.txtHey() +
                                      profileInfo.name!,
                                  style: TextStyle(
                                      fontFamily:
                                          Fonts.getFontFamilyTitillRegular(),
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 156,
                            height: 250,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 15, top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: ColorsCode.purpleColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/icons/phone.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "010 94642511",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: Fonts
                                              .getFontFamilyTitillRegular(),
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/icons/map.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "010 94642511",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: Fonts
                                              .getFontFamilyTitillRegular(),
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Card(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/kid_circ.png",
                                  ),
                                  Text(
                                    Language.instance.txtHey() +
                                        profileInfo.name!,
                                    style: TextStyle(
                                      fontFamily:
                                          Fonts.getFontFamilyTitillSemiBold(),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 15,
                                      children: [
                                        Bounce(
                                          onPressed: () {},
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            label: Text(profileInfo.age! +
                                                Language.instance.txtYear()),
                                            avatar: SvgPicture.asset(
                                                "assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            label: Text(profileInfo.birthdate!),
                                            avatar: SvgPicture.asset(
                                                "assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            label: Text(
                                                "Cm ${profileInfo.height}"),
                                            avatar: SvgPicture.asset(
                                                "assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            label: Text(
                                                "Kg ${profileInfo.weight}"),
                                            avatar: SvgPicture.asset(
                                                "assets/images/icons/bold.dot.svg"),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Language.instance.txtCharacteristics(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.characteristics!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Language.instance.txtBehavior(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.behavior!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Language.instance.txtSpecialChar(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.specialCharacteristics!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Language.instance.txtAllergies(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.allergies!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Language.instance.txtDiet(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.diet!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Language.instance.txtDiseases(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts
                                            .getFontFamilyTitillSemiBold()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileInfo.diseases!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular()),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
