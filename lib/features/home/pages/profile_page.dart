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

  String? _selected;
   final List<Map> _myList = [
    {'id': '1', 'image': 'assets/images/young_woman_white.svg'},
    {'id': '2', 'image': 'assets/images/young_woman_black.svg'},
    {'id': '3', 'image': 'assets/images/young_man_white.svg'},
    {'id': '4', 'image': 'assets/images/young_man_black.svg'},
    {'id': '5', 'image': 'assets/images/old_woman_white.svg'},
    {'id': '6', 'image':'assets/images/old_woman_black.svg'},
    {'id': '7', 'image': 'assets/images/old_man_black.svg'},
    {'id': '8', 'image': 'assets/images/old_man _white.svg'},
  ];

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
                      fillColor: ColorsCode.whiteColor100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple.shade100,
                      )),
                      hintText: Strings.txtIsEmptyUserName,
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
                    color: ColorsCode.whiteColor100,
                    //llColor: ColorsCode.whiteColor100,

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
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: _phoneNumController,
                    formatInput: false,
                    maxLength: 11,
                    spaceBetweenSelectorAndTextField: 2,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    cursorColor: Colors.black,
                    inputDecoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(bottom: 15, left: 8),
                      border: InputBorder.none,
                      hintText: Strings.txtHintPhoneNumber,
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
                      fillColor: ColorsCode.whiteColor100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple.shade100,
                      )),
                      hintText: Strings.txtHintEmail,
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

                      DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            value: _selected,
                            onChanged: (newValue){
                              setState(() {
                                _selected = newValue;
                              });
                            },
                            items: _myList.map((Map imgItem){
                              return DropdownMenuItem(
                                value: imgItem['id'].toString(),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height:25,
                                          width: 25,
                                          child: SvgPicture.asset(
                                            imgItem['image'],
                                            width: 25,
                                            color: Colors.black,
                                          ),
                                      ),
                                    ],
                                  ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
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
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Rest and Cancel',
                              style: TextStyle(
                                color: Colors.black,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
