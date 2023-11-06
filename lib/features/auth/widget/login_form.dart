// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_me/constants/fonts.dart';

import '../../../../constants/Strings.dart';
import '../Screens/home_screen.dart';
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
            MaterialPageRoute(builder: (context) => HomePage()),
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
        padding: const EdgeInsets.all(22.0),
        margin: const EdgeInsets.all(15.0),
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
                height: 20,
              ),
              Text(
                Strings.txtWelcomeLogin,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: Fonts.getFontFamilyCairo(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                Strings.txtWelcomeLogin2,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyCairo(),
                ),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: Strings.txtEmail,
                          hintText: Strings.txtHintEmail,
                          //isDense: true,
                        ),
                        validator: (value) {
                          return Validation.validateEmail(value ?? "");
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        //keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: Strings.txtPassword,
                          hintText: Strings.txtHintPassword,
                        ),
                        validator: (value) {
                          return Validation.validatePassword(value ?? "");
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                            ),
                            onPressed: () {
                              loginUserFun();
                            },
                            child: Text(
                              Strings.txtButtonLogin,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: Fonts.getFontFamilyAbel(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              Strings.txtDoNotHaveAcc,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
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
                              child: const Text(
                                Strings.txtButtonRegister,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
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
