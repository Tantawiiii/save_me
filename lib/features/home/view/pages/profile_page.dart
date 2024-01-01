// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ndialog/ndialog.dart';
import 'package:save_me/data/api_client.dart';
import 'package:save_me/features/auth/models/user_model.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../widgets/loading_dialog.dart';
import '../utils/image_picker_cropper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addInfoController = TextEditingController();

  // initial Country Code value phone number
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  // Default selected image path
  String selectedValue = 'Old_woman_white';

  // Image Picker for the new photo profile image
  File? image;

  Future<void> _pickAndCropImage() async {
    ImagePickerCropper imagePickerCropper = ImagePickerCropper();
    File? croppedImage = await imagePickerCropper.pickAndCropImage(context);

    if (croppedImage != null) {
      setState(() {
        image = croppedImage;
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
        child: Center(
          child: ListView(
            children: [
              FutureBuilder(
                  future: ApiClient.getUserProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData = snapshot.data as User?;
                      _nameController =
                          TextEditingController(text: userData?.name);
                      _phoneNumController =
                          TextEditingController(text: userData?.phoneNumber);
                      _addInfoController = TextEditingController(
                        text: (userData?.contactInfo == "" ||
                                userData?.contactInfo == "null")
                            ? Language.instance.txtAdditionInfo()
                            : userData?.contactInfo,
                      );
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              cursorColor: Colors.black,
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
                                hintText: Language.instance.txtHintName(),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.blackColor700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
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
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.13)),
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
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              initialValue: number,
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              textFieldController: _phoneNumController,
                              formatInput: false,
                              spaceBetweenSelectorAndTextField: 0,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                              ),
                              cursorColor: Colors.black,
                              inputDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 15, left: 8),
                                border: InputBorder.none,
                                hintText:
                                    Language.instance.txtHintPhoneNumber(),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.blackColor700,
                                ),
                              ),
                              onSaved: (PhoneNumber number) {},
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            Language.instance.txtAddInfo(),
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
                              controller: _addInfoController,
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.black,
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
                                hintText: Language.instance.txtAddInfo(),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.blackColor700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            Language.instance.txtAvatarOrPhoto(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  elevation: 0,
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ),
                                  iconSize: 20,
                                  dropdownColor: Colors.grey.shade200,
                                  items: [
                                    'Old_man_black',
                                    'Old_man_white',
                                    'Old_woman_black',
                                    'Old_woman_white',
                                    'young_man_Black',
                                    'young_man_white',
                                    'young_woman_black',
                                    'young_woman_white',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200),
                                            child: Image.asset(
                                              'assets/images/icons/$value.png',
                                              width: 65,
                                              // Adjust the size as needed
                                              height: 65,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  'Or',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold(),
                                    fontWeight: FontWeight.normal,
                                    color: ColorsCode.grayColor100,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _pickAndCropImage();
                                      },
                                      child: Container(
                                        width: 125,
                                        height: 89,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white54,
                                          child: image == null &&
                                                  (userData?.photoUrl == null ||
                                                      userData?.photoUrl ==
                                                          "null")
                                              ? SvgPicture.asset(
                                                  'assets/images/upload_img.svg')
                                              : image != null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: CircleAvatar(
                                                        radius: 45,
                                                        backgroundImage:
                                                            FileImage(
                                                          image!,
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: CircleAvatar(
                                                        radius: 45,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          userData!.photoUrl!,
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      Language.instance.txtUploadImage(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: Fonts
                                              .getFontFamilyTitillRegular(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Bounce(
                                duration: const Duration(milliseconds: 300),
                                onPressed: () {
                                  updateDataInProfile(userData!);
                                },
                                child: Container(
                                  height: 56,
                                  width: 180,
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
                                  setState(() {
                                    _phoneNumController.toString();
                                  });

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
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 46,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Center(
                      child: LoadingDialog(isLoading: true),
                      // CircularProgressIndicator(
                      //     valueColor:
                      //         AlwaysStoppedAnimation<Color>(Colors.black))
                    );
                  }),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateDataInProfile(User user) async {
    final name = _nameController.text;
    final phone = _phoneNumController.text;
    final addInfo = _addInfoController.text;
    final userUpdated =
        user.copyWith(name: name, phoneNumber: phone, contactInfo: addInfo);
    User? updatedUser = await ApiClient().updateUserProfile(userUpdated);

    if (updatedUser != null) {
      if (image != null) {
        await ApiClient()
            .uploadUserImage(
              image: image!,
            )
            .showCustomProgressDialog(context);
      }
      if (Platform.isIOS || Platform.isAndroid) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: Language.instance.txtUpdateMsg());
      }
    }
  }
}
