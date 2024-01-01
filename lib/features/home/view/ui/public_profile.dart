import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/utils/strings/Language.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../auth/models/user_model.dart';
import '../../../internet/no_internet.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  String locationName = "";
  double latitude = 51.507769;
  double longitude = 7.6350688;
  GoogleMapController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() async {
    await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? const NoInternet()
              : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                          latitude = userData!.location!.latitude!;
                          longitude = userData.location!.longitude!;
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(
                                top: 24, right: 20, left: 20, bottom: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: ListView(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 8,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: 150,
                                          height: 300,
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 2, top: 2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                                height: 14,
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
                                              if (widget.profileInfo.message !=
                                                      "" &&
                                                  widget.profileInfo.message !=
                                                      "null")
                                                Text(
                                                  "${widget.profileInfo.message}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: Fonts
                                                          .getFontFamilyTitillRegular(),
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              Text(
                                                Language.instance
                                                    .txtDefaultMassage(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: Fonts
                                                        .getFontFamilyTitillRegular(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: 150,
                                          height: 300,
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: ColorsCode.purpleColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                  if (userData.phoneNumber! !=
                                                          "" &&
                                                      userData.phoneNumber !=
                                                          "null")
                                                    Flexible(
                                                      child: Text(
                                                        "${userData.phoneNumber}",
                                                        textAlign:
                                                            TextAlign.center,
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
                                                height: 8,
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
                                                height: 8,
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
                                                    target: LatLng(
                                                        latitude, longitude),
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
                                                      markerId: MarkerId("1"),
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
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/icons/info.svg'),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  if (userData.contactInfo !=
                                                          "" &&
                                                      userData.contactInfo !=
                                                          "null")
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
                                              if (widget.profileInfo.photoUrl !=
                                                      "" &&
                                                  widget.profileInfo.photoUrl !=
                                                      null)
                                                ClipRRect(
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
                                                height: 18,
                                              ),
                                              Center(
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.center,
                                                  spacing: 15,
                                                  children: [
                                                    if (widget.profileInfo
                                                                .age! !=
                                                            "" &&
                                                        widget.profileInfo
                                                                .age !=
                                                            "null")
                                                      Bounce(
                                                        onPressed: () {},
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        child: Chip(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          label: Text(
                                                            widget.profileInfo
                                                                    .age! +
                                                                Language
                                                                    .instance
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
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        child: Chip(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
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
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        child: Chip(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
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
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        child: Chip(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
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
                                              if (widget.profileInfo
                                                          .behavior! !=
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
                                                      widget.profileInfo
                                                          .behavior!,
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
                                              if (widget.profileInfo
                                                          .allergies! !=
                                                      "" &&
                                                  widget.profileInfo
                                                          .allergies !=
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
                                                      widget.profileInfo
                                                          .allergies!,
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
                                                      Language.instance
                                                          .txtDiet(),
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
                                              if (widget.profileInfo
                                                          .diseases! !=
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
                                                      widget.profileInfo
                                                          .diseases!,
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
                                                          .medicines! !=
                                                      "" &&
                                                  widget.profileInfo
                                                          .medicines !=
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
                                                      widget.profileInfo
                                                          .medicines!,
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
                                              if (widget
                                                          .profileInfo
                                                          .institution
                                                          ?.locationIn!
                                                          .nameLocation !=
                                                      "" &&
                                                  widget
                                                          .profileInfo
                                                          .institution
                                                          ?.locationIn!
                                                          .nameLocation !=
                                                      null &&
                                                  widget
                                                          .profileInfo
                                                          .institution
                                                          ?.locationIn!
                                                          .nameLocation !=
                                                      "null")
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Language.instance
                                                          .txtSeniorLocation(),
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
                                                              .profileInfo
                                                              .institution
                                                              ?.locationIn!
                                                              .nameLocation ??
                                                          "",
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
                                              if (widget.profileInfo.institution
                                                          ?.nameIn !=
                                                      "" &&
                                                  widget.profileInfo.institution
                                                          ?.nameIn !=
                                                      null)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Language.instance
                                                          .txtSeniorInstitute(),
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
                                                              .profileInfo
                                                              .institution
                                                              ?.nameIn! ??
                                                          "",
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
                                              if (widget.profileInfo.institution
                                                          ?.aidNameIn !=
                                                      "" &&
                                                  widget.profileInfo.institution
                                                          ?.aidNameIn !=
                                                      null)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Language.instance
                                                          .txtSeniorCareAide(),
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
                                                              .profileInfo
                                                              .institution
                                                              ?.aidNameIn! ??
                                                          "",
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
                                              if (widget.profileInfo.institution
                                                          ?.aidPhoneNumberIn !=
                                                      "" &&
                                                  widget.profileInfo.institution
                                                          ?.aidPhoneNumberIn !=
                                                      null)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Language.instance
                                                          .txtSeniorCareAidePhone(),
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
                                                              .profileInfo
                                                              .institution
                                                              ?.aidPhoneNumberIn! ??
                                                          "",
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
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black)),
                        );
                      }),
                );
        });
  }
}
