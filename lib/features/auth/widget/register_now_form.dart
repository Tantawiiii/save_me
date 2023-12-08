import 'package:flutter/material.dart';

import '../../../constants/strings/Strings_en.dart';
import '../../../constants/colors_code.dart';
import '../../../constants/fonts.dart';
import '../../../constants/strings/utils/Language.dart';
import '../../api_helper/api_client.dart';
import '../utils/validation.dart';

class RegisterNowForm extends StatefulWidget {
  const RegisterNowForm({super.key});

  @override
  State<RegisterNowForm> createState() => _RegisterNowFormState();
}

class _RegisterNowFormState extends State<RegisterNowForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Initialize Dio with ApiClient
  final ApiClient _apiClient = ApiClient();

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
          Language.instance.txtEmail(),
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
            keyboardType: TextInputType.emailAddress,
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
        SizedBox(
          height: 56,
          child: TextFormField(
            controller: _passwordController,
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
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
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
          height: 24,
        ),
        Text(
          Language.instance.txtConfirmPassword(),
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
              hintText: Language.instance.txtHintConfirmPassword(),
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
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                return Language.instance.txtHintConfirmPassword();
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return Language.instance.txtNotMatchPassword();
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
