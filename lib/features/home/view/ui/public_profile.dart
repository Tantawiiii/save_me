import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/utils/strings/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../auth/models/user_model.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  static const LatLng _kMapCenter = LatLng(29.9674624, 31.3154334);

  static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 70,
        shadowColor: Colors.black45,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
          future: ApiClient.getUserProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data as User?;
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(top: 24, right: 20, left: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: [
                          Container(
                            width: 169,
                            height: 270,
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
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
                                  userData != null ? userData!.name : Language.instance.txtIsEmptyUserName(),
                                  style: TextStyle(
                                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  userData!.contactInfo ?? "",
                                  style: TextStyle(fontFamily: Fonts.getFontFamilyTitillRegular(), fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 169,
                            height: 270,
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
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
                                    SvgPicture.asset('assets/images/icons/phone.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null ? userData!.phoneNumber : Language.instance.txtHintPhoneNumber(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontFamily: Fonts.getFontFamilyTitillRegular(), color: Colors.black),
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
                                    SvgPicture.asset('assets/images/icons/map.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null ? userData?.location!.name : Language.instance.txtHintLocation(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontFamily: Fonts.getFontFamilyTitillRegular(), color: Colors.black),
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
                                    SvgPicture.asset('assets/images/icons/info.svg'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData != null ? userData!.email : Language.instance.txtHintLocation(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontFamily: Fonts.getFontFamilyTitillRegular(), color: Colors.black),
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
                          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                    Language.instance.txtHey() + widget.profileInfo.name!,
                                    style: TextStyle(
                                      fontFamily: Fonts.getFontFamilyTitillSemiBold(),
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
                                          duration: const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                            label: Text(widget.profileInfo.age! + Language.instance.txtYear()),
                                            avatar: SvgPicture.asset("assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration: const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                            label: Text(widget.profileInfo.birthdate!),
                                            avatar: SvgPicture.asset("assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration: const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                            label: Text("Cm ${widget.profileInfo.height}"),
                                            avatar: SvgPicture.asset("assets/images/icons/bold.dot.svg"),
                                          ),
                                        ),
                                        Bounce(
                                          onPressed: () {},
                                          duration: const Duration(milliseconds: 400),
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                            label: Text("Kg ${widget.profileInfo.weight}"),
                                            avatar: SvgPicture.asset("assets/images/icons/bold.dot.svg"),
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
                                  if (widget.profileInfo.characteristics! != "" && widget.profileInfo.characteristics != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtCharacteristics(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.characteristics!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.behavior! != "" && widget.profileInfo.behavior != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtBehavior(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.behavior!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.specialCharacteristics! != "" && widget.profileInfo.specialCharacteristics != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtSpecialChar(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.specialCharacteristics!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.allergies! != "" && widget.profileInfo.allergies != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtAllergies(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.allergies!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.diet! != "" && widget.profileInfo.diet != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtDiet(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.diet!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  if (widget.profileInfo.diseases! != "" && widget.profileInfo.diseases != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Language.instance.txtDiseases(),
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          widget.profileInfo.diseases!,
                                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular()),
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
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
