import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/widgets/delete_dialog.dart';
import 'package:save_me/features/widgets/share_dialog.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Strings_en.dart';

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
                elevation: 4,
                margin: const EdgeInsets.only(
                    top: 24, right: 15, left: 15, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 15,
                    left: 15,
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsCode.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){

                            },
                              child: SvgPicture.asset('assets/images/icons/eye.svg'),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset('assets/images/icons/edit.svg'),
                          const SizedBox(
                            width: 12,
                          ),

                          InkWell(
                            onTap: (){
                               shareDialog(context, onPressed: (){});
                            },
                            child: SvgPicture.asset('assets/images/icons/share.svg'),
                          ),

                          const SizedBox(
                            width: 12,
                          ),
                          Bounce(
                            onPressed: (){},
                            duration: const Duration(milliseconds: 400),
                            child: InkWell(
                              onTap: (){
                                deleteDialog(context, onPressed: (){});
                              },
                                child: SvgPicture.asset('assets/images/icons/delete.svg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
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
                                "Hey I am   ${profileInfo.name!}",
                                style: TextStyle(
                                  fontFamily:
                                      Fonts.getFontFamilyTitillSemiBold(),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 18,),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 15,
                                  children: [
                                    Bounce(
                                      onPressed: (){},
                                      duration: const Duration(milliseconds: 400),
                                      child: Chip(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                        label: Text(
                                            "${profileInfo.age}  Years Old "),
                                        avatar: SvgPicture.asset(
                                            "assets/images/icons/bold.dot.svg"),
                                      ),
                                    ),
                                    Bounce(
                                      onPressed: (){},
                                      duration: const Duration(milliseconds: 400),
                                      child: Chip(
                                        shape:  const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                        label: Text(
                                          profileInfo.birthdate!
                                        ),
                                        avatar: SvgPicture.asset(
                                            "assets/images/icons/bold.dot.svg"),
                                      ),
                                    ),
                                    Bounce(
                                      onPressed: (){},
                                      duration: const Duration(milliseconds: 400),
                                      child: Chip(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                        label: Text(
                                            "Cm ${profileInfo.height}"),
                                        avatar: SvgPicture.asset(
                                            "assets/images/icons/bold.dot.svg"),
                                      ),
                                    ),
                                    Bounce(
                                      onPressed: (){},
                                      duration: const Duration(milliseconds: 400),
                                      child: Chip(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
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
                                'Characteristics',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
                                'Behaviour',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
                                'Special Characteristics',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
                                'Allergies',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
                                'Diet',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
                                'Diseases',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold()),
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
