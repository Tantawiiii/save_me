import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/home/view/ui/public_profile.dart';
import 'package:save_me/features/widgets/share_dialog.dart';
import 'package:save_me/utils/strings/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 0, bearing: 0);

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
                      Language.instance.txtAppBarHome(),
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
                margin: const EdgeInsets.only(top: 24, right: 20, left: 20, bottom: 20),
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
                            child: SvgPicture.asset('assets/images/icons/eye.svg'),
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
                            child: SvgPicture.asset('assets/images/icons/share.svg'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Bounce(
                            onPressed: () {},
                            duration: const Duration(milliseconds: 400),
                            child: InkWell(
                              onTap: () {
                                deleteDialog(context);
                              },
                              child: SvgPicture.asset('assets/images/icons/delete.svg'),
                            ),
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
  void deleteDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 350,
            padding: const EdgeInsets.only(top: 4, right: 24, bottom: 4, left: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delete Confirmation",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Are you sure you want to delete this profile? This action is irreversible, and all your data will be permanently lost.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Bounce(
                  duration: const Duration(milliseconds: 300),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.black,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        "No, I don’t want",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Bounce(
                  duration: const Duration(milliseconds: 300),
                  onPressed: () {},
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.redAccent,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        "Yes, Delete this profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
