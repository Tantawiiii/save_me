import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../../utils/strings/Strings_en.dart';
import '../../../auth/models/user_model.dart';
import '../../../widgets/loading_dialog.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // function to autoComplete the location

  TextEditingController locationController = TextEditingController();
  String locationName = "";
  double latitude = 51.507769;
  double longitude = 7.6350688;
  CameraPosition? cameraPosition;
  GoogleMapController? mapController;
  String location = Language.instance.txtHintReturnLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 20, right: 24, left: 24),
        child: ListView(
          children: [
            FutureBuilder(
                future: ApiClient.getUserProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data as User?;
                    locationController =
                        TextEditingController(text: userData?.location?.name);
                    latitude = userData!.location!.latitude!;
                    longitude = userData.location!.longitude!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Language.instance.txtReturnLocation(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                              fontWeight: FontWeight.normal,
                              color: ColorsCode.grayColor100),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 56,
                          child: GooglePlaceAutoCompleteTextField(
                            isCrossBtnShown: false,
                            textEditingController: locationController,
                            googleAPIKey: StringsEn.API_KEY_Google,
                            boxDecoration: BoxDecoration(
                              color: ColorsCode.whiteColor100,
                            ),
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 9,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0, top: 3, bottom: 3, right: 8),
                                child: Icon(
                                  Icons.my_location_outlined,
                                  size: 24,
                                ),
                              ),
                              filled: true,
                              fillColor: ColorsCode.whiteColor100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.purple.shade100,
                              )),
                              hintText: Language.instance.txtHintLocation(),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
                                color: ColorsCode.grayColor,
                              ),
                            ),
                            debounceTime: 800,
                            countries: const ["eg", "de"],
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              latitude = double.parse(prediction.lat!);
                              longitude = double.parse(prediction.lng!);
                            },
                            itemClick: (Prediction prediction) {
                              // TODO: Error Location Lat , Long
                              // Handle the location details directly in the itemClick callback
                              locationName = prediction.description ?? "";
                              locationController.text = locationName;
                              locationController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(offset: locationName.length),
                              );

                              // Move the camera to the selected location
                              mapController!.animateCamera(
                                CameraUpdate.newLatLng(
                                    LatLng(latitude, longitude)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          Language.instance.txtDragLocation(),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Fonts.getFontFamilyTitillRegular(),
                            fontWeight: FontWeight.normal,
                            color: ColorsCode.grayColor100,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(latitude, longitude),
                              zoom: 14.0,
                              tilt: 0,
                              bearing: 0,
                            ),
                            onTap: (pos) {
                              if (kDebugMode) {
                                print("onTap: $pos");
                              }
                              latitude = pos.latitude;
                              longitude = pos.longitude;
                              log(latitude.toString());
                              setState(() {});
                            },
                            mapType: MapType.terrain,
                            zoomGesturesEnabled: true,
                            onMapCreated: (controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },
                            onCameraMove: (CameraPosition position) {
                              cameraPosition = position;
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId("1"),
                                icon: BitmapDescriptor.defaultMarker,
                                position: LatLng(latitude, longitude),
                              ),
                            },
                            circles: {
                              Circle(
                                circleId: const CircleId("1"),
                                center: LatLng(latitude, longitude),
                                radius: 750,
                                strokeWidth: 1,
                                fillColor:
                                    const Color(0xFF006491).withOpacity(0.2),
                              ),
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce(
                              duration: const Duration(milliseconds: 300),
                              onPressed: () {
                                updateDataInProfile(userData);
                              },
                              child: Container(
                                height: 56,
                                width: 200,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Text(
                                    Language.instance.txtUpdate(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily:
                                          Fonts.getFontFamilyTitillSemiBold(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Bounce(
                              duration: const Duration(milliseconds: 300),
                              onPressed: () {
                                setState(() {});

                                if (Platform.isIOS || Platform.isAndroid) {
                                  Fluttertoast.showToast(
                                      toastLength: Toast.LENGTH_SHORT,
                                      msg: Language.instance.txtResetMsg());
                                }
                              },
                              child: Container(
                                height: 56,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Text(
                                    Language.instance.txtRestCancel(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily:
                                          Fonts.getFontFamilyTitillSemiBold(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                    child: LoadingDialog(isLoading: true),
                    //
                    // CircularProgressIndicator(
                    //     valueColor:
                    //         AlwaysStoppedAnimation<Color>(Colors.black))
                  );
                }),
          ],
        ),
      ),
    );
  }

  void updateDataInProfile(User user) async {
    final userUpdated = user.copyWith(
        location: Location(
            name: locationController.text,
            latitude: latitude,
            longitude: longitude));
    print("$locationName: $latitude $longitude");
    await ApiClient().updateUserProfile(userUpdated);
    if (Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: Language.instance.txtUpdateMsg());
    }
  }
}
