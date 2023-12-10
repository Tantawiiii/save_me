// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:save_me/features/auth/Screens/login_screen.dart';
import 'package:save_me/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isTextFieldVisible = false;

  bool passwordVisible = true;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
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
                                  backgroundColor: ColorsCode.purpleColorLight,
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
                                  backgroundColor: ColorsCode.whiteColor100,
                                  elevation: 0,
                                  //elevated button background color
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
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 56,
                            child: TextFormField(
                              controller: _oldPasswordController,
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              //focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
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
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),

                                  // color: Colors.purple.shade100,
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 56,
                            child: TextFormField(
                              controller: _newPasswordController,
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              //focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorsCode.whiteColor100,

                                //labelText: Strings.txtPassword,
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
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),

                                  // color: Colors.purple.shade100,
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
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
                                // if (_newPasswordController.text !=
                                //     _confirmPasswordController.text) {
                                //   return Strings.txtNotMatchPassword;
                                // }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 56,
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              //focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorsCode.whiteColor100,

                                //labelText: Strings.txtPassword,
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
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),

                                  // color: Colors.purple.shade100,
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
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
                            setState(() {
                              // Toggle the visibility state
                              isTextFieldVisible = !isTextFieldVisible;
                            });
                            //}
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
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

  changeLanguage(lang) async {
    if (SaveMe.getLocal(context).languageCode == 'de') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "EN");

      Language.instance.setLanguage("EN");

      Locale newLocale = const Locale('en');
      SaveMe.setLocale(context, newLocale);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("language", "DE");

      Language.instance.setLanguage("DE");

      Locale newLocale = const Locale('de');
      SaveMe.setLocale(context, newLocale);
    }

    setState(() {
      //EasyLoading.showSuccess("Changed");
      Phoenix.rebirth(context);
    });
  }
}
