// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import '../../../data/api_client.dart';
import '../../../utils/constants/colors_code.dart';
import '../../../utils/constants/fonts.dart';
import '../../../utils/strings/Language.dart';
import '../../home/home_screen.dart';
import '../../widgets/loading_dialog.dart';
import '../utils/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  static String id = 'LoginScreen';

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final Validation validation = Validation();
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(24.0),
            //margin: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Language.instance.txtWelcomeLogin(),
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: Fonts.getFontFamilyTitillBold(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    Language.instance.txtWelcomeLogin2(),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: Fonts.getFontFamilyTitillRegular(),
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 56),
                  Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Language.instance.txtEmail(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular(),
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
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
                            hintText: Language.instance.txtHintEmail(),
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
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          Language.instance.txtPassword(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular(),
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: passwordVisible,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: ColorsCode.whiteColor100,
                            //labelText: Strings.txtPassword,
                            hintText: Language.instance.txtHintPassword(),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular(),
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
                        const SizedBox(
                          height: 56,
                        ),
                        Bounce(
                          duration: const Duration(milliseconds:200),
                            onPressed: (){
                              _handleButtonClick();
                              loginUserFun();
                            },
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                            ),
                            child: Center(
                              child: Text(
                                Language.instance.txtButtonLogin(),
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
                          height: 24,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Language.instance.txtDoNotHaveAcc(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.getFontFamilyTitillRegular(),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Bounce(
                                duration: const Duration(milliseconds: 150),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, "/register");
                                },
                                child: Text(
                                  Language.instance.txtButtonRegister(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: Fonts.getFontFamilyTitillBold(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Future<void> loginUserFun() async {

    if ( _formKey1.currentState?.validate() ?? false ) {
      String email = _emailController.text;
      String password = _passwordController.text;

      dynamic user = await ApiClient.loginUser(
        _emailController.text,
        _passwordController.text,
      );

      LoadingDialog(isLoading: isLoading);

      if (user != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pushReplacementNamed(context, "/home");

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const HomeScreen()),
        // );

        //print('accessToken: $accessToken');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Your Email or password is wrong ..'),
          backgroundColor: Colors.red.shade300,
        ));
      }


    }


  }

}
