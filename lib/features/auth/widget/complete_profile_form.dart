import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../data/api_client.dart';
import '../../../utils/constants/colors_code.dart';
import '../../../utils/constants/fonts.dart';
import '../../../utils/strings/Language.dart';
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Language.instance.txtWelcomeRegister(),
            style: TextStyle(
              fontSize: 24,
              fontFamily: Fonts.getFontFamilyTitillBold(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            Language.instance.txtWelcomeRegister2(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Fonts.getFontFamilyTitillRegular(),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            Language.instance.txtUserName(),
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
                  ),
                ),
                hintText: Language.instance.txtHintUserName(),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyTitillRegular(),
                  color: ColorsCode.grayColor,
                ),
                //isDense: true,
              ),
              validator: (value) {
                return Validation.validateName(value ?? "");
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            Language.instance.txtLocation(),
            style: TextStyle(
                fontSize: 14,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 8,
          ),
          // Auto Located Place
          SizedBox(
            height: 56,
            child: TextFormField(
              controller: _locationController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding:
                      EdgeInsets.only(left: 15.5, top: 3, bottom: 3, right: 8),
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
                //isDense: true,
              ),
              // validator: (value) {
              //   return Validation.validateEmail(value ?? "");
              // },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            Language.instance.txtPhoneNumber(),
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
            padding: const EdgeInsets.only(left: 12, right: 5),
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
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              cursorColor: Colors.black,
              inputDecoration: InputDecoration(
                //prefixIcon: SvgPicture.asset('assets/images/line.svg'),
                contentPadding: const EdgeInsets.only(bottom: 15, left: 8),
                border: InputBorder.none,
                hintText: Language.instance.txtHintPhoneNumber(),
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
      ),
    );
  }
}
