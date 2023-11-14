// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_me/constants/fonts.dart';

import '../../../../constants/Strings.dart';
import '../../home/home_screen.dart';
import '../Screens/register_screen.dart';
import '../dataSource/api_client.dart';
import '../utils/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  static String id = 'LoginScreen';

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final Validation valid = Validation();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

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
    Future<void> loginUserFun() async {
      if (_formKey.currentState!.validate()) {
        String email = _emailController.text;
        String password = _passwordController.text;

        final user = await _apiClient.loginUser(
            _emailController.text, _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Progress Check Data'),
          backgroundColor: Colors.blueAccent,
        ));

        if (user != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (kDebugMode) {
            print('Email: $email');
            print('Password: $password');
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error Login: $user'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24.0),
        //margin: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(5), // Add rounded corners
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 3,
          //     blurRadius: 3,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.txtWelcomeLogin,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: Fonts.getFontFamilyTitillBold(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                Strings.txtWelcomeLogin2,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Fonts.getFontFamilyTitillRegular(),
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 56),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                            borderSide: BorderSide(
                              color: Colors.white
                            ),
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
                            icon: Icon(passwordVisible
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
                      height: 56,
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
                            // loginUserFun();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          child: Text(
                            Strings.txtButtonLogin,
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
                            Strings.txtDoNotHaveAcc,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: Fonts.getFontFamilyTitillRegular(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                            child: Text(
                              Strings.txtButtonRegister,
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
        ),
      ),
    );
  }
}
