import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';
import 'package:save_me/features/home/home_screen.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/home/view/edit_cards/edit_kid_profile.dart';
import 'package:save_me/features/home/view/edit_cards/edit_pet_profile.dart';
import 'package:save_me/features/home/view/edit_cards/edit_senior_profile.dart';
import 'package:save_me/features/home/view/ui/public_profile.dart';
import 'package:save_me/features/widgets/delete_dialog.dart';
import 'package:save_me/features/widgets/share_dialog.dart';
import 'package:save_me/utils/strings/Language.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../auth/models/user_model.dart';
import '../../../internet/no_internet.dart';
import '../../../widgets/loading_dialog.dart';
import '../edit_cards/edit_disabled_profile.dart';
import '../edit_cards/edit_item_profile.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String locationName = "";
  double latitude = 51.507769;
  double longitude = 7.6350688;

  double latitudeInstitute = 51.507769;
  double longitudeInstitute = 7.6350688;

  GoogleMapController? _controller;

  // to show TextFailed  to Update the massage.
  bool isEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() async {
    await Connectivity().checkConnectivity();
  }

  TextEditingController _massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String svgAssetPath = '';
    switch (widget.profileInfo.profileType) {
      case "ITEM":
        svgAssetPath = 'assets/images/Item.svg';
        break;
      case "DISABLED_PERSON":
        svgAssetPath = 'assets/images/Disabled.svg';
        break;
      case "KID":
        svgAssetPath = 'assets/images/kids.svg';
        break;
      case "PET":
        svgAssetPath = 'assets/images/Pets.svg';
        break;
      case "SENIOR":
        svgAssetPath = 'assets/images/Seniors.svg';
        break;
      default:
        svgAssetPath = 'assets/images/Item.svg';
    }

    _massageController =
        TextEditingController(text: widget.profileInfo.message);
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? const NoInternet()
              : FutureBuilder(
                  future: ApiClient.getUserProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData = snapshot.data as User?;
                      latitude = userData!.location!.latitude!;
                      longitude = userData.location!.longitude!;

                      // latitudeInstitute = widget
                      //         .profileInfo.institution!.locationIn!.latitude! ??
                      //     0.0;
                      // longitudeInstitute = widget.profileInfo.institution!
                      //         .locationIn!.longitude! ??
                      //     0.0;

                      return Scaffold(
                        appBar: AppBar(
                          systemOverlayStyle: const SystemUiOverlayStyle(
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark,
                          ),
                          title: Column(
                            children: [
                              Text(
                                Language.instance.txtAppBarHome() +
                                        userData.name ??
                                    "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillSemiBold(),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                Language.instance.txtAppBarWelcome(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          toolbarHeight: 70,
                          elevation: 8,
                          shadowColor: Colors.black45,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Image(
                                image: AssetImage(
                                    'assets/images/logowithnobg.png'),
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
                                      child: SvgPicture.asset(
                                          'assets/images/icons/eye.svg'),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        switch (
                                            widget.profileInfo.profileType) {
                                          case "ITEM":
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditItemProfile(
                                                  profileInfo:
                                                      widget.profileInfo,
                                                ),
                                              ),
                                            );
                                            break;
                                          case "DISABLED_PERSON":
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditDisabledProfile(
                                                  profileInfo:
                                                      widget.profileInfo,
                                                ),
                                              ),
                                            );
                                            break;
                                          case "KID":
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditKidProfile(
                                                  profileInfo:
                                                      widget.profileInfo,
                                                ),
                                              ),
                                            );
                                            break;
                                          case "PET":
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditPetProfile(
                                                  profileInfo:
                                                      widget.profileInfo,
                                                ),
                                              ),
                                            );
                                            break;
                                          case "SENIOR":
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditSeniorProfile(
                                                  profileInfo:
                                                      widget.profileInfo,
                                                ),
                                              ),
                                            );
                                            break;
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/icons/edit.svg'),
                                    ),
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
                                        deleteDialog(context,
                                            onPressed: () async {
                                          try {
                                            await deleteUserProfileData(
                                                widget.profileInfo.id!);
                                            Fluttertoast.showToast(
                                                msg: Language.instance
                                                    .txtToastDelete());
                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(
                                                    builder: (context) {
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
                                  height: 16,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 320,
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 2, top: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: ColorsCode.purpleColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage: NetworkImage(
                                              userData.photoUrl!,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          if (userData.name! != "" &&
                                              userData.name != "null")
                                            Text(
                                              "${userData.name}",
                                              style: TextStyle(
                                                fontFamily: Fonts
                                                    .getFontFamilyTitillSemiBold(),
                                                fontSize: 16,
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          if (!isEditing)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                widget.profileInfo.message !=
                                                            "" &&
                                                        widget.profileInfo
                                                                .message !=
                                                            null
                                                    ? Text(
                                                        Language.instance
                                                            .txtDefaultMassage(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: Fonts
                                                                .getFontFamilyTitillRegular(),
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    : Text(
                                                        "${widget.profileInfo.message}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: Fonts
                                                                .getFontFamilyTitillRegular(),
                                                            fontSize: 12,
                                                            color: Colors.red),
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isEditing = !isEditing;
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/icons/edit.svg",
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (isEditing)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 65,
                                                  child: TextFormField(
                                                    controller:
                                                        _massageController,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    cursorColor: Colors.black,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                        bottom: 0,
                                                        left: 2,
                                                        right: 2,
                                                      ),
                                                      filled: true,
                                                      fillColor: ColorsCode
                                                          .whiteColor100,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .purple.shade100,
                                                        ),
                                                      ),
                                                      hintText: Language
                                                          .instance
                                                          .txtMassageHint(),
                                                      hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillRegular(),
                                                        color: ColorsCode
                                                            .grayColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Bounce(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  onPressed: () {
                                                    // update the Message
                                                    _updateMassageProfile(
                                                        widget.profileInfo);

                                                    // to close the message Filed
                                                    setState(() {
                                                      isEditing = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      color: Colors.black,
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Language.instance
                                                            .txtUpdate(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: Fonts
                                                              .getFontFamilyTitillSemiBold(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Bounce(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  onPressed: () {
                                                    setState(() {
                                                      isEditing = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Language.instance
                                                            .txtCancel(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: Fonts
                                                              .getFontFamilyTitillSemiBold(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      height: 320,
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 15,
                                          top: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: ColorsCode.purpleColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/icons/phone.svg'),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              if (userData.phoneNumber! != "" &&
                                                  userData.phoneNumber !=
                                                      "null")
                                                Flexible(
                                                  child: Text(
                                                    "${userData.phoneNumber}",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillRegular(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/icons/map.svg'),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              if (userData.location!.name !=
                                                      "" &&
                                                  userData.location!.name !=
                                                      "null")
                                                Flexible(
                                                  child: Text(
                                                    "${userData.location!.name}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                            height: 12,
                                          ),
                                          Container(
                                            height: 135,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: GoogleMap(
                                              mapType: MapType.normal,
                                              compassEnabled: true,
                                              mapToolbarEnabled: true,
                                              zoomGesturesEnabled: true,
                                              zoomControlsEnabled: false,
                                              myLocationEnabled: true,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target:
                                                    LatLng(latitude, longitude),
                                                zoom: 14.0,
                                                tilt: 0,
                                                bearing: 0,
                                              ),
                                              onMapCreated: (controller) {
                                                setState(() {
                                                  _controller = controller;
                                                });
                                              },
                                              markers: {
                                                Marker(
                                                  markerId: const MarkerId("1"),
                                                  icon: BitmapDescriptor
                                                      .defaultMarker,
                                                  visible: true,
                                                  position: LatLng(
                                                      latitude, longitude),
                                                ),
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          if (userData.contactInfo != "" &&
                                              userData.contactInfo != "null")
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/images/icons/info.svg'),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    userData.contactInfo!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            widget.profileInfo.photoUrl == null
                                                ? SvgPicture.asset(
                                                    svgAssetPath,
                                                    width: 100,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        widget.profileInfo
                                                            .photoUrl!,
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            if (widget.profileInfo.name! !=
                                                    "" &&
                                                widget.profileInfo.name !=
                                                    "null")
                                              Text(
                                                Language.instance.txtHey() +
                                                    widget.profileInfo.name!,
                                                style: TextStyle(
                                                  fontFamily: Fonts
                                                      .getFontFamilyTitillSemiBold(),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            if (widget.profileInfo
                                                        .institution?.aidNameIn !=
                                                    "" &&
                                                widget.profileInfo.institution
                                                        ?.aidNameIn !=
                                                    null &&
                                                widget.profileInfo.institution
                                                        ?.aidNameIn !=
                                                    "null")
                                              Column(
                                                children: [
                                                  Text(
                                                    "${Language.instance.txtLive()} ${widget.profileInfo.institution?.nameIn!} \n ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: Fonts
                                                          .getFontFamilyTitillRegular(),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${Language.instance.txtCare()} ${widget.profileInfo.institution?.aidNameIn!} \n "
                                                    "${Language.instance.txtCarePhone()} ${widget.profileInfo.institution?.aidPhoneNumberIn!}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: Fonts
                                                          .getFontFamilyTitillRegular(),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${Language.instance.txtLive()} ${widget.profileInfo.institution?.nameIn!} \n "
                                                    "${Language.instance.txtCare()} ${widget.profileInfo.institution?.aidNameIn!} \n "
                                                    "${Language.instance.txtCarePhone()} ${widget.profileInfo.institution?.aidPhoneNumberIn!}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: Fonts
                                                          .getFontFamilyTitillRegular(),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Center(
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                spacing: 15,
                                                children: [
                                                  if (widget.profileInfo.age! !=
                                                          "" &&
                                                      widget.profileInfo.age !=
                                                          "null")
                                                    Bounce(
                                                      onPressed: () {},
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      child: Chip(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        label: Text(
                                                          widget.profileInfo
                                                                  .age! +
                                                              Language.instance
                                                                  .txtYear(),
                                                        ),
                                                        avatar: SvgPicture.asset(
                                                            "assets/images/icons/bold.dot.svg"),
                                                      ),
                                                    ),
                                                  if (widget.profileInfo
                                                              .birthdate! !=
                                                          "" &&
                                                      widget.profileInfo
                                                              .birthdate !=
                                                          "null")
                                                    Bounce(
                                                      onPressed: () {},
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      child: Chip(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        label: Text(widget
                                                            .profileInfo
                                                            .birthdate!),
                                                        avatar: SvgPicture.asset(
                                                            "assets/images/icons/bold.dot.svg"),
                                                      ),
                                                    ),
                                                  if (widget.profileInfo
                                                              .height! !=
                                                          "" &&
                                                      widget.profileInfo
                                                              .height !=
                                                          "null")
                                                    Bounce(
                                                      onPressed: () {},
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      child: Chip(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        label: Text(
                                                            "${widget.profileInfo.height} Cm"),
                                                        avatar: SvgPicture.asset(
                                                            "assets/images/icons/bold.dot.svg"),
                                                      ),
                                                    ),
                                                  if (widget.profileInfo
                                                              .weight! !=
                                                          "" &&
                                                      widget.profileInfo
                                                              .weight !=
                                                          "null")
                                                    Bounce(
                                                      onPressed: () {},
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      child: Chip(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        label: Text(
                                                            "${widget.profileInfo.weight} Kg"),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (widget.profileInfo
                                                        .characteristics! !=
                                                    "" &&
                                                widget.profileInfo
                                                        .characteristics !=
                                                    "null")
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
                                                    widget.profileInfo
                                                        .characteristics!,
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
                                            if (widget.profileInfo.behavior! !=
                                                    "" &&
                                                widget.profileInfo.behavior !=
                                                    "null")
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtBehavior(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillSemiBold()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    widget
                                                        .profileInfo.behavior!,
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
                                                    "null")
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtSpecialChar(),
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
                                            if (widget.profileInfo.allergies! !=
                                                    "" &&
                                                widget.profileInfo.allergies !=
                                                    "null")
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtAllergies(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillSemiBold()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    widget
                                                        .profileInfo.allergies!,
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
                                            if (widget.profileInfo.diet! !=
                                                    "" &&
                                                widget.profileInfo.diet !=
                                                    "null")
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
                                                    "null")
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtAdditionInfo(),
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
                                            if (widget.profileInfo.diseases! !=
                                                    "" &&
                                                widget.profileInfo.diseases !=
                                                    'null')
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtDiseases(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillSemiBold()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    widget
                                                        .profileInfo.diseases!,
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
                                            if (widget.profileInfo.medicines! !=
                                                    "" &&
                                                widget.profileInfo.medicines !=
                                                    'null')
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Language.instance
                                                        .txtMedicines(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: Fonts
                                                            .getFontFamilyTitillSemiBold()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    widget
                                                        .profileInfo.medicines!,
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
                      child: LoadingDialog(isLoading: true),
                    ));
                  });
        });
  }

  LatLng getTargetLatLng() {
    // fix this error Null check operator used on a null value
    var institution = widget.profileInfo.institution;
    if (institution != null) {
      var locationIn = institution.locationIn;
      if (locationIn != null) {
        var latitude = locationIn.latitude;
        var longitude = locationIn.longitude;
        if (latitude != null && longitude != null) {
          return LatLng(latitude, longitude);
        }
      }
    }

    // Return a default LatLng or handle null case based on your requirements
    return const LatLng(0.0, 0.0);
  }

  void _updateMassageProfile(ProfileInfo profileInfo) async {
    final massage = _massageController.text;

    final profileUpdate = profileInfo.copyWith(
      message: massage,
    );
    await updateProfile(widget.profileInfo.id!, profileUpdate);
  }

// Delete item from the list
}
