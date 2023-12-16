import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/view/pages/location/web_services/network_utils.dart';


import '../../../../../utils/constants/colors_code.dart';
import '../../../../../utils/constants/fonts.dart';
import '../../../../../utils/strings/Language.dart';
import '../../../../widgets/upload_bottom_sheet.dart';


@RoutePage()
class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  // function to autoComplete the location
  void placeAutoComplete(String query) async {
    Uri uri =
        Uri.http("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": Language.instance.API_KEY_Google(),
    });
    // get request
    String? response = await NetworkUtils.fetchUrl(uri);

    if (response != null) {
      if (kDebugMode) {
        print(response);
      }
    }
  }

  TextEditingController locationController = TextEditingController();

  // to add Icon Marker on MapView
  Set<Marker> _createMarker() {
    return {
      const Marker(
        markerId: MarkerId("mark1"),
        position: _kMapCenter,
        infoWindow: InfoWindow(title: "Marker 1"),
        rotation: 0,
      )
    };
  }

  static const LatLng _kMapCenter = LatLng(  29.9674624, 31.3154334);
  CameraPosition? cameraPosition;
  GoogleMapController? mapController;
  String location =  Language.instance.txtHintReturnLocation();

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 30, right: 24, left: 24),
        child: Column(
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
              height: 58,
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.streetAddress,
                controller: locationController,
                textInputAction: TextInputAction.search,

                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.5,
                      right: 8,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      width: 20,
                      height: 20,
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
                  hintText: Language.instance.txtHintReturnLocation(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillRegular(),
                    color: ColorsCode.grayColor,
                  ),
                  //isDense: true,
                ),
                // validator: (value) {
                //   return Validation.validateEmail(value ?? "");
                // },
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
                        initialCameraPosition: _kInitialPosition,
                        mapType: MapType.hybrid,
                        //zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        // trafficEnabled: true,
                        // liteModeEnabled: true,
                        //markers: _createMarker(),
                        onMapCreated: (controller) {
                          setState(() {
                            mapController = controller;
                          });
                        },
                        onCameraMove: (CameraPosition position) {
                          cameraPosition = position;
                        },
                        //when map drag stops
                        onCameraIdle: () async {
                          List<Placemark> placeMarks =
                              await placemarkFromCoordinates(
                                  cameraPosition!.target.latitude,
                                  cameraPosition!.target.longitude);
                          //get place name from lat and lang
                          setState(() {
                            location =
                                "${placeMarks.first.administrativeArea}, ${placeMarks.first.street}";
                            locationController.text = location;
                          });
                        },
                      ),
                    ),

                    Center(
                      child: Icon(
                        Icons.location_pin,
                        size: 46,
                        color: Colors.red.shade900,
                      ),
                    ),

                    //widget to display location name
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(0),
                              width: 330,
                              child: ListTile(
                                leading: const Icon(Icons.location_on),
                                title: Text(
                                  location,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                dense: true,
                              )),
                        ),
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
                        showBottomSheetDialog(context);
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
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
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
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
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
        ),
      ),
    );
  }
}
