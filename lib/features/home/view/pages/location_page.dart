import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:save_me/main.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../../utils/strings/Strings_en.dart';
import '../../../auth/models/user_model.dart';

@RoutePage()
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
        child: FutureBuilder(
            future: ApiClient.getUserProfileData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data as User?;
                locationController =TextEditingController(text: userData?.location?.name);
                latitude = userData!.location!.latitude!;
                longitude = userData!.location!.longitude!;
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
                          hintText:Language.instance.txtHintLocation(),
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
                          if (prediction.lat != null &&
                              prediction.lng != null) {
                            latitude = double.parse(prediction.lat!);
                            longitude = double.parse(prediction.lng!);
                          }
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
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      Language.instance.txtDragLocation(),
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: Fonts.getFontFamilyTitillRegular(),
                          fontWeight: FontWeight.normal,
                          color: ColorsCode.grayColor100),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 400,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(latitude, longitude),
                                  zoom: 14.0,
                                  tilt: 0,
                                  bearing: 0,
                                ),
                                onTap: (pos){
                                  print("onTap: $pos");
                                  setState(() {
                                    latitude = pos.latitude;
                                        longitude = pos.longitude;
                                  });
                                } ,
                                mapType: MapType.normal,
                                zoomGesturesEnabled: true,
                                // onMapCreated: (controller) {
                                //   setState(() {
                                //     mapController = controller;
                                //   });
                                // },
                                // onCameraMove: (CameraPosition position) {
                                //   cameraPosition = position;
                                // },
                                //when map drag stops
                                // onCameraIdle: () async {
                                //   List<Placemark> placeMarks =
                                //       await placemarkFromCoordinates(
                                //           cameraPosition!.target.latitude,
                                //           cameraPosition!.target.longitude);
                                //   //get place name from lat and lang
                                //   setState(() {
                                //     location =
                                //         "${placeMarks.first.administrativeArea}, ${placeMarks.first.street}";
                                //     locationController.text = location;
                                //   });
                                // },
                                markers:  {
                                   Marker(
                                    markerId: MarkerId("1"),
                                    icon:BitmapDescriptor.defaultMarker,
                                    position: LatLng(latitude, longitude),
                                  ),
                                },
                                circles: {
                                  Circle(
                                    circleId: CircleId("1"),
                                    center: LatLng(latitude, longitude),
                                    radius: 750,
                                    strokeWidth: 1,
                                    fillColor: Color(0xFF006491).withOpacity(0.2),
                                  ),
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                //   showBottomSheetDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
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
                          width: 2,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
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

              return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
            }),
      ),
    );
  }
}
