import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';
import 'package:save_me/features/home/home_screen.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/home/view/ui/public_profile.dart';
import 'package:save_me/features/widgets/delete_dialog.dart';
import 'package:save_me/features/widgets/share_dialog.dart';
import 'package:save_me/utils/strings/Language.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../auth/models/user_model.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  static const LatLng _kMapCenter = LatLng(29.9674624, 31.3154334);

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiClient.getUserProfileData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data as User?;
            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                title: Column(
                  children: [
                    Text(
                      Language.instance.txtAppBarHome() + userData!.name ?? "",
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
                // actions: [
                //   IconButton(
                //     icon: const Icon(Icons.notifications_active),
                //     padding: const EdgeInsets.only(right: 12),
                //     onPressed: () {},
                //   ),
                // ],
                elevation: 8,
                shadowColor: Colors.black45,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Image(
                      image: AssetImage('assets/images/logowithnobg.png'),
                    ),
                  ),
                ),
                centerTitle: true,
                // backgroundColor: Theme.of(context).colorScheme.primary,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Card(
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
                            onTap: () {
                              // handel public profile Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PublicProfile(
                                    profileInfo: widget.profileInfo,
                                  ),
                                ),
                              );
                            },
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
                              shareDialog(
                                context,
                                onPressed: () {},
                                profileId: widget.profileInfo.id!,
                              );
                            },
                            child: SvgPicture.asset(
                                'assets/images/icons/share.svg'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: () {
                              deleteDialog(context, onPressed: () async {
                                try {
                                  await deleteUserProfileData(
                                      widget.profileInfo.id!);
                                  Fluttertoast.showToast(
                                      msg: "Profile deleted successfully");
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeScreen();
                                  }), (route) => false);
                                } catch (e) {
                                  log(e.toString());
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong");
                                }
                              });
                            },
                            child: SvgPicture.asset(
                                'assets/images/icons/delete.svg'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: [
                          Container(
                            width: 170,
                            height: 280,
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
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/images/image.png'),
                                ),
                                const SizedBox(height: 16,),
                                Text(
                                  userData != null
                                      ? userData!.name
                                      : Language.instance.txtIsEmptyUserName(),
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
                                  userData!.contactInfo ?? "",
                                  textAlign: TextAlign.center,
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
                            width: 170,
                            height: 280,
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
                              children: <Widget>[
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/icons/phone.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null
                                            ? userData!.phoneNumber
                                            : Language.instance
                                                .txtHintPhoneNumber(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: Fonts
                                                .getFontFamilyTitillRegular(),
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/icons/map.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null
                                            ? userData?.location!.name
                                            : Language.instance
                                                .txtHintLocation(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: Fonts
                                                .getFontFamilyTitillRegular(),
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 135,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const GoogleMap(
                                    mapType: MapType.hybrid,
                                    initialCameraPosition: _kInitialPosition,
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/icons/info.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null
                                            ? userData!.email
                                            : Language.instance
                                                .txtHintLocation(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: Fonts
                                                .getFontFamilyTitillRegular(),
                                            color: Colors.black),
                                      ),
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

                                  const SizedBox(
                                    height: 24,
                                  ),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: widget.profileInfo.photoUrl == null
                                        ? const CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                                'assets/images/image.png'),
                                          )
                                        : CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              widget.profileInfo.photoUrl!,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  if (widget.profileInfo.name! != "" &&
                                      widget.profileInfo.name != "null")
                                    Text(
                                      Language.instance.txtHey() +
                                          widget.profileInfo.name!,
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
                                        if (widget.profileInfo.age! != "" &&
                                            widget.profileInfo.age != "null")
                                          Bounce(
                                            onPressed: () {},
                                            duration: const Duration(
                                                milliseconds: 400),
                                            child: Chip(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              label: Text(
                                                widget.profileInfo.age! +
                                                    Language.instance.txtYear(),
                                              ),
                                              avatar: SvgPicture.asset(
                                                  "assets/images/icons/bold.dot.svg"),
                                            ),
                                          ),
                                        if (widget.profileInfo.birthdate! !=
                                                "" &&
                                            widget.profileInfo.birthdate !=
                                                "null")
                                          Bounce(
                                            onPressed: () {},
                                            duration: const Duration(
                                                milliseconds: 400),
                                            child: Chip(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              label: Text(widget
                                                  .profileInfo.birthdate!),
                                              avatar: SvgPicture.asset(
                                                  "assets/images/icons/bold.dot.svg"),
                                            ),
                                          ),
                                        if (widget.profileInfo.height! != "" &&
                                            widget.profileInfo.height != "null")
                                          Bounce(
                                            onPressed: () {},
                                            duration: const Duration(
                                                milliseconds: 400),
                                            child: Chip(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              label: Text(
                                                  "Cm ${widget.profileInfo.height}"),
                                              avatar: SvgPicture.asset(
                                                  "assets/images/icons/bold.dot.svg"),
                                            ),
                                          ),
                                        if (widget.profileInfo.weight! != "" &&
                                            widget.profileInfo.weight != "null")
                                          Bounce(
                                            onPressed: () {},
                                            duration: const Duration(
                                                milliseconds: 400),
                                            child: Chip(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              label: Text(
                                                  "Kg ${widget.profileInfo.weight}"),
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
                                  if (widget.profileInfo.characteristics! !=
                                          "" &&
                                      widget.profileInfo.characteristics !=
                                          null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance
                                              .txtCharacteristics(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.characteristics!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.behavior! != "" &&
                                      widget.profileInfo.behavior != null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          widget.profileInfo.behavior!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo
                                              .specialCharacteristics! !=
                                          "" &&
                                      widget.profileInfo
                                              .specialCharacteristics !=
                                          null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          widget.profileInfo
                                              .specialCharacteristics!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.allergies! != "" &&
                                      widget.profileInfo.allergies != null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          widget.profileInfo.allergies!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.diet! != "" &&
                                      widget.profileInfo.diet != null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          widget.profileInfo.diet!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo
                                              .additionalInformation! !=
                                          "" &&
                                      widget.profileInfo
                                              .additionalInformation !=
                                          null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtAdditionInfo(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo
                                              .additionalInformation!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.diseases! != "" &&
                                      widget.profileInfo.diseases != null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          widget.profileInfo.diseases!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }

// Delete item from the list
}
