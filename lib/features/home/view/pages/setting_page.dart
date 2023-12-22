// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_me/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../auth/utils/validation.dart';
import '../../../widgets/loading_dialog.dart';

@RoutePage()
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final Validation validation = Validation();
  bool isTextFieldVisible = false;

  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool confirmPasswordVisible = true;
  final FocusNode _passwordFocusNode = FocusNode();

  Color backBtnPurple = ColorsCode.purpleColorLight;
  Color backBtnWhite = ColorsCode.whiteColor100;
  String currentLang = "";
  @override
  void initState() {
    super.initState();
    oldPasswordVisible = true;
     newPasswordVisible = true;
     confirmPasswordVisible = true;
    currentLang = Language.instance.getLanguage();

  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Handel a Loading bar when the translate a language.
  bool isLoading = false;

  void _handleButtonClick() {
    // Set loading to true to show the loading indicator
    setState(() {
      isLoading = true;
    });

    // Simulate a 1-second delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      // Set loading to false to hide the loading indicator after the delay
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 30, right: 24, left: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 51,
                      decoration: BoxDecoration(
                        color: ColorsCode.whiteColor100,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    changeLanguage("en");
                                    _handleButtonClick();

                                  });
                                },
                                icon: SvgPicture.asset(
                                    'assets/images/English.svg'),
                                //icon data for elevated button
                                label: Text(
                                  Language.instance.txtEnglish(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold(),
                                    fontSize: 16,
                                  ),
                                ),
                                //label text
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentLang == "EN" ?  backBtnPurple :backBtnWhite,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    changeLanguage("de");
                                    _handleButtonClick();

                                  });
                                },
                                icon: SvgPicture.asset(
                                    'assets/images/Deutsch.svg'),
                                //icon data for elevated button
                                label: Text(
                                  Language.instance.txtGermany(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        Fonts.getFontFamilyTitillSemiBold(),
                                    fontSize: 16,
                                  ),
                                ),
                                //label text
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentLang == "DE" ? backBtnPurple :backBtnWhite,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Visibility(
                      visible: isTextFieldVisible,
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _oldPasswordController,
                              obscureText: oldPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorsCode.whiteColor100,
                                //labelText: Strings.txtPassword,
                                hintText:
                                    Language.instance.txtHintOldPassword(),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.grayColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.purple.shade100,
                                )),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    oldPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),

                                  // color: Colors.purple.shade100,
                                  onPressed: () {
                                    setState(
                                      () {
                                        oldPasswordVisible = !oldPasswordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                return Validation.validatePassword(value ?? "");
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: newPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorsCode.whiteColor100,
                                hintText:
                                    Language.instance.txtHintNewPassword(),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.grayColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.purple.shade100,
                                )),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    newPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),

                                  // color: Colors.purple.shade100,
                                  onPressed: () {
                                    setState(
                                      () {
                                        newPasswordVisible = !newPasswordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                return Validation.validatePassword(value ?? "");
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: confirmPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorsCode.whiteColor100,
                                hintText: Language.instance
                                    .txtHintConfirmNewPassword(),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                      Fonts.getFontFamilyTitillRegular(),
                                  color: ColorsCode.grayColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.purple.shade100,
                                )),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        confirmPasswordVisible = !confirmPasswordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Language.instance
                                      .txtHintConfirmPassword();
                                }
                                if (_newPasswordController.text !=
                                    _confirmPasswordController.text) {
                                  return Language.instance
                                      .txtNotMatchPassword();
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 200),
                      onPressed: () {},
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ClipRRect(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              if (_oldPasswordController.text.isEmpty &&
                                  _newPasswordController.text.isEmpty &&
                                  _confirmPasswordController.text.isEmpty) {
                                setState(() {
                                  // Toggle the visibility state
                                  isTextFieldVisible = !isTextFieldVisible;
                                });
                              } else {
                                _handleChangePassword();
                              }
                            },
                            child: Text(
                              Language.instance.txtChangePassword(),
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
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Language.instance.txtLogOut(),
                          style: TextStyle(
                            color: ColorsCode.redColor,
                            fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              // to remove an access Token and logout
                              setToken();
                              Navigator.pushReplacementNamed(context, "/splash");
                            },
                            child:
                                SvgPicture.asset('assets/images/Logout.svg')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Loading animation overlay
          LoadingDialog(isLoading: isLoading),
        ],
      ),
    );
  }

  // TODO: DONE & fixed Change password ..
  // change password functionality
  Future<void> _handleChangePassword() async {
    String currentPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;

    if (_formKey1.currentState!.validate()) {
      dynamic updatePassSuccess = await ApiClient().changePassword(
        currentPassword,
        newPassword,
      );

      if (updatePassSuccess != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Change Password Successfully'),
          backgroundColor: Colors.blue.shade200,
        ));
        setState(() {
          // Toggle the visibility state
          isTextFieldVisible = !isTextFieldVisible;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Failed to change password'),
          backgroundColor: Colors.red.shade300,
        ));

        setState(() {
          // Toggle the visibility state
          isTextFieldVisible = !isTextFieldVisible;
        });
      }
    }
  }

  static Future<bool> setToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString("access_token", '');
  }

  changeLanguage(lang) async {
    if (SaveMe.getLocal(context).languageCode == 'de') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "EN");

      Language.instance.setLanguage("EN");
    currentLang = "EN";
      setState(() {

      });
      Locale newLocale = const Locale('en');
      SaveMe.setLocale(context, newLocale);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "DE");

      Language.instance.setLanguage("DE");
      currentLang = "DE";
      setState(() {

      });
      Locale newLocale = const Locale('de');
      SaveMe.setLocale(context, newLocale);
    }

    // setState(() {
    //   //EasyLoading.showSuccess("Changed");
    //   Phoenix.rebirth(context);
    // });
  }
}
