
import 'package:flutter/material.dart';

import '../../../constants/Strings.dart';
import '../../../constants/fonts.dart';
import '../dataSource/api_client.dart';
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
        const SizedBox(
          height: 16,
        ),
        Text(
          Strings.txtWelcomeRegister,
          style: TextStyle(
            fontSize: 24,
            fontFamily: Fonts.getFontFamilyTitillBold(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          Strings.txtWelcomeRegister2,
          style: TextStyle(
            fontSize: 16,
            fontFamily: Fonts.getFontFamilyTitillRegular(),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          Strings.txtEmail,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
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
          Strings.txtPassword,
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
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              //labelText: Strings.txtPassword,
              hintText: Strings.txtHintPassword,
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
          Strings.txtConfirmPassword,
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
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              //labelText: Strings.txtPassword,
              hintText: Strings.txtHintConfirmPassword,
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
                return Strings.txtHintConfirmPassword;
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return Strings.txtNotMatchPassword;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
