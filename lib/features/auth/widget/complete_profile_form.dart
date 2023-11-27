
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../constants/Strings.dart';
import '../../../constants/colors_code.dart';
import '../../../constants/fonts.dart';
import '../dataSource/api_client.dart';
import '../utils/validation.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {

  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Initialize Dio with ApiClient
  final ApiClient _apiClient = ApiClient();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.txtWelcomeRegister,
          style: TextStyle(
            fontSize: 24,
            fontFamily: Fonts.getFontFamilyTitillBold(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          Strings.txtWelcomeRegister2,
          style: TextStyle(
            fontSize: 14,
            fontFamily: Fonts.getFontFamilyTitillRegular(),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          Strings.txtUserName,
          style: TextStyle(
              fontSize: 14,
              fontFamily: Fonts.getFontFamilyTitillRegular(),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 56,
          child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
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
              hintText: Strings.txtHintUserName,
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                color: ColorsCode.grayColor,
              ),
              //isDense: true,
            ),
            validator: (value) {
              return Validation.validateEmail(value ?? "");
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          Strings.txtLocation,
          style: TextStyle(
              fontSize: 14,
              fontFamily: Fonts.getFontFamilyTitillRegular(),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 8,
        ),
        // Auto Located Place
       GooglePlaceAutoCompleteTextField(
            isCrossBtnShown: true,
            textEditingController: _locationController,
            googleAPIKey: Strings.API_KEY,
            inputDecoration:  InputDecoration(
              hintText: Strings.txtHintLocation,
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                color: ColorsCode.grayColor,
              ),
              filled: true,
              fillColor: ColorsCode.whiteColor100,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,

              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple.shade100,
                  )),
             // labelText: Strings.txtLocation,
            ),
            debounceTime: 800,
            countries: const ["eg", "de"],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              if (kDebugMode) {
                print("placeDetails${prediction.lng}");
              }
            },
            itemClick: (Prediction prediction) {
              _locationController.text = prediction.description!;
              _locationController.selection =
                  TextSelection.fromPosition(TextPosition(
                      offset: prediction.description!.length));
            },
          ),
        const SizedBox(height: 24),
        Text(
          Strings.txtPhoneNumber,
          style: TextStyle(
              fontSize: 14,
              fontFamily: Fonts.getFontFamilyTitillRegular(),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.only(left: 12,right: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black.withOpacity(0.13)),
          ),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            initialValue: number,
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            textFieldController: _phoneNumController,
            formatInput: false,
            //maxLength: 11,
            spaceBetweenSelectorAndTextField: 0,
            keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
            cursorColor: Colors.black,
            inputDecoration:  InputDecoration(
              //prefixIcon: SvgPicture.asset('assets/images/line.svg'),
              contentPadding: const EdgeInsets.only(bottom: 15, left: 8),
              border: InputBorder.none,
              hintText:Strings.txtHintPhoneNumber,
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                color: ColorsCode.grayColor,
              ),

            ),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ),
        /////////////////////////////

      ],
    );
  }
}


// SizedBox(
//   height: 56,
//   child: TextFormField(
//     controller: _phoneNumController,
//     keyboardType: TextInputType.phone,
//     decoration: InputDecoration(
//       filled: true,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//       ),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.purple.shade100,
//           )),
//       hintText: Strings.txtHintPhoneNumber,
//       //isDense: true,
//     ),
//     validator: (value) {
//       return Validation.validateEmail(value ?? "");
//     },
//   ),
// ),