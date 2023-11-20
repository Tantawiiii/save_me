import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/features/auth/Screens/login_screen.dart';

import '../../../constants/Strings.dart';
import '../../../constants/fonts.dart';
import '../../auth/utils/validation.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;
  FocusNode _passwordFocusNode = FocusNode();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 36, right: 24, left: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
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
                              print("You pressed Icon Elevated Button");
                            },
                            icon: SvgPicture.asset('assets/images/English.svg'),
                            //icon data for elevated button
                            label: Text(
                                Strings.txtEnglish,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                fontSize: 16,
                              ),),
                            //label text
                            style: ElevatedButton.styleFrom(
                              primary: ColorsCode.purpleColorLight,
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              print("You pressed Icon Elevated Button");
                            },
                            icon: SvgPicture.asset('assets/images/Deutsch.svg'),
                            //icon data for elevated button
                            label: Text(
                              Strings.txtGermany,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                fontSize: 16,
                              ),
                            ),
                            //label text
                            style: ElevatedButton.styleFrom(
                                primary: ColorsCode.whiteColor100,
                                elevation: 0 //elevated btton background color
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

                // SizedBox(
                //   height: 56,
                //   child: TextFormField(
                //     controller: _passwordController,
                //     obscureText: passwordVisible,
                //     keyboardType: TextInputType.visiblePassword,
                //     focusNode: _passwordFocusNode,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //
                //         borderRadius: BorderRadius.circular(4),
                //       ),
                //       filled: true,
                //       //labelText: Strings.txtPassword,
                //       hintText: Strings.txtNewPassword,
                //       focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.purple.shade100,
                //           )),
                //       suffixIcon: IconButton(
                //         icon: Icon(passwordVisible
                //             ? Icons.visibility
                //             : Icons.visibility_off,
                //           color: Colors.grey,
                //         ),
                //
                //         // color: Colors.purple.shade100,
                //         onPressed: () {
                //           setState(
                //                 () {
                //               passwordVisible = !passwordVisible;
                //             },
                //           );
                //         },
                //       ),
                //     ),
                //     textInputAction: TextInputAction.done,
                //     validator: (value) {
                //       return Validation.validatePassword(value ?? "");
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 16,
                ),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        Strings.txtChangePassword,
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
                  height:32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.txtLogOut,
                      style: TextStyle(
                        color: ColorsCode.redColor,
                        fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 120,
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/Logout.svg')
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
