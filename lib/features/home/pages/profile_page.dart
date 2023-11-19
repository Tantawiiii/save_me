import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:save_me/constants/colors_code.dart';

import '../../../constants/Strings.dart';
import '../../../constants/fonts.dart';
import '../../auth/utils/validation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 40, right: 24, left: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple.shade100,
                      )),
                      hintText: Strings.txtIsEmptyUserName,
                      //isDense: true,
                    ),
                    validator: (value) {
                      return Validation.validateEmail(value ?? "");
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
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
                  padding: const EdgeInsets.only(left: 12),
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
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: _phoneNumController,
                    formatInput: false,
                    maxLength: 11,
                    spaceBetweenSelectorAndTextField: 2,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    cursorColor: Colors.black,
                    inputDecoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                      border: InputBorder.none,
                      hintText: Strings.txtHintPhoneNumber,
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  Strings.txtAddInfo,
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
                    controller: _emailController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple.shade100,
                      )),
                      hintText: Strings.txtHintEmail,
                      //isDense: true,
                    ),
                    validator: (value) {
                      return Validation.validateEmail(value ?? "");
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  Strings.txtAvatarOrPhoto,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/upload_img.svg'),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                            fontWeight: FontWeight.normal),
                      ),
                      Column(
                        children: <Widget>[
                          SvgPicture.asset('assets/images/upload_img.svg'),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Upload a photo',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                color: ColorsCode.purpleColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 56,
                        width: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Update',
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
                        width: 6,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              elevation: 0,
                            ),
                            child: const Text('Rest and Cancel'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
