import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_me/features/home/pages/location/web_services/network_utils.dart';

import '../../../../constants/Strings.dart';
import '../../../../constants/colors_code.dart';
import '../../../../constants/fonts.dart';
import '../../widgets/upload_bottom_sheet.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  // function to autoComplete the location
  void placeAutoComplete(String query) async {
    Uri uri = Uri.http(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input" : query,
        "key" : Strings.API_KEY,
      }
    );
    // get request
    String? response = await NetworkUtils.fetchUrl(uri);

    if (response != null) {
      print(response);

    }

  }


  static const LatLng _kMapCenter = LatLng(30.648090,31.133470);

  static const CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 40, right: 24, left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.txtReturnLocation,
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
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      onChanged: (value){
                        // to search  a location automatically


                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15.5,top: 3, bottom: 3,right:8),
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
                        hintText: Strings.txtHintReturnLocation,
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
                    Strings.txtDragLocation,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: Fonts.getFontFamilyTitillRegular(),
                        fontWeight: FontWeight.normal,
                        color: ColorsCode.grayColor100),
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  ////////////////////////////Google Map Location  //////////////////////////
                  Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const SizedBox(
                      child: GoogleMap(
                        initialCameraPosition: _kInitialPosition ,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 48,
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
                              Strings.txtUpdate,
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
                              Strings.txtRestCancel,
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
                ],
              ),
            ),
          ),
        ),
    );
  }
}
