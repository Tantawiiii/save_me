// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:save_me/data/api_client.dart';
import 'package:save_me/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../auth/utils/validation.dart';

import 'package:auto_route/auto_route.dart';

import '../../../widgets/upload_bottom_sheet.dart';

@RoutePage()
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addInfoController = TextEditingController();

  // initial Country Code value phone number
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  // Default selected image path
  final SvgPicture _selectedImage = SvgPicture.asset('assets/images/young_man_white.svg');
  List<Map<String, dynamic>> mySvgPaths = [
    {"id": '1', "image": 'assets/images/young_man_white.svg'},
    {"id": '2', "image": 'assets/images/young_man_white.svg'},
    {"id": '3', "image": 'assets/images/young_man_white.svg'},
    {"id": '4', "image": 'assets/images/young_man_white.svg'},
    {"id": '5', "image": 'assets/images/young_man_white.svg'},
    {"id": '6', "image": 'assets/images/young_man_white.svg'},
    {"id": '7', "image": 'assets/images/young_man_white.svg'},
    {"id": '8', "image": 'assets/images/young_man_white.svg'},
  ];

  // Image Picker for the new photo profile image
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 30, right: 24, left: 24),
        child: ListView(
          children: [
            FutureBuilder(
                future: ApiClient.getUserProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data as User?;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Language.instance.txtUserName(),
                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular(), fontWeight: FontWeight.normal),
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
                              hintText: userData != null ? userData!.name : Language.instance.txtIsEmptyUserName(),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
                                color: ColorsCode.blackColor700,
                              ),
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
                          Language.instance.txtPhoneNumber(),
                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular(), fontWeight: FontWeight.normal),
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
                              if (kDebugMode) {
                                print(number.phoneNumber);
                              }
                            },
                            onInputValidated: (bool value) {
                              if (kDebugMode) {
                                print(value);
                              }
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
                            spaceBetweenSelectorAndTextField: 0,
                            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                            cursorColor: Colors.black,
                            inputDecoration: InputDecoration(
                              //prefixIcon: SvgPicture.asset('assets/images/line.svg'),
                              contentPadding: const EdgeInsets.only(bottom: 15, left: 8),
                              border: InputBorder.none,
                              hintText: userData != null ? userData!.phoneNumber : Language.instance.txtHintPhoneNumber(),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
                                color: ColorsCode.blackColor700,
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
                          Language.instance.txtAddInfo(),
                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillRegular(), fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 56,
                          child: TextFormField(
                            controller: _addInfoController,
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
                              hintText: userData == null ? userData?.contactInfo : Language.instance.txtAddInfo(),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
                                color: ColorsCode.blackColor700,
                              ),
                              //isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          Language.instance.txtAvatarOrPhoto(),
                          style: TextStyle(fontSize: 14, fontFamily: Fonts.getFontFamilyTitillSemiBold(), fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // DropdownButton(
                              //         isDense: true,
                              //         value: _selectedImage,
                              //         onChanged: null,
                              //         items: [
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //           DropdownMenuItem(child: SvgPicture.asset('assets/images/young_man_white.svg'),),
                              //         ],
                              //       ),
                              //
                              // Text(
                              //   'OR',
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                              //     fontWeight: FontWeight.normal,
                              //     color: ColorsCode.grayColor100,
                              //   ),
                              // ),
                              Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _pickImage();
                                    },
                                    child: Container(
                                      width: 148,
                                      height: 89,
                                      decoration: BoxDecoration(
                                        color: ColorsCode.whiteColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                      ),
                                      child: _image == null
                                          ? Center(
                                              child: SvgPicture.asset('assets/images/upload_img.svg'),
                                            )
                                          : Image.file(
                                              _image!,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Upload a photo',
                                    style: TextStyle(fontSize: 16, fontFamily: Fonts.getFontFamilyTitillRegular(), color: ColorsCode.purpleColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 46,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // showBottomSheetDialog(context);
                                    updateDataInProfile(userData!);
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
                            const SizedBox(
                              height: 46,
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
                }),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  void updateDataInProfile(User user) async {
    final name = _nameController.text;
    final phone = _phoneNumController.text;
    final addInfo = _addInfoController.text;
    final userUpdated = user.copyWith(name: name, phoneNumber: phone, contactInfo: addInfo);
    User? updatedUser = await ApiClient().updateUserProfile(userUpdated);
    if (updatedUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Update Date Info Successfully'),
        backgroundColor: Colors.blue.shade200,
      ));
    }
  }
}
