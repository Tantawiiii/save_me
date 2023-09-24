import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:save_me/constants/settings.dart';
import 'package:save_me/src/features/authentication/Screens/login_screen.dart';

import '../../../../constants/Strings.dart';
import '../utils/validation.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(22.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5), // Add rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  Strings.txtWelcomeRegister,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  Strings.txtWelcomeRegister2,
                  style: TextStyle(fontSize: 15),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: Strings.txtName,
                            hintText: Strings.txtHintName,
                          ),
                          validator: (value) {
                            return Validation.validateName(value ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: Strings.txtUserName,
                            hintText: Strings.txtHintUserName,
                          ),
                          validator: (value) {
                            return Validation.validateName(value ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _phoneNumController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: Strings.txtPhoneNumber,
                            hintText: Strings.txtHintPhoneNumber,
                          ),
                          validator: (value) {
                            //return Validation.validatePhoneNumber(value ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                            return Validation.validatePassword(value ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                          height: 15,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: Strings.txtConfirmPassword,
                            hintText: Strings.txtHintConfirmPassword,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Strings.txtHintConfirmPassword;
                            }
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              return Strings.txtNotMatchPassword;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // Auto Located Place
                        GooglePlaceAutoCompleteTextField(
                          textEditingController: _locationController,
                          googleAPIKey: Strings.API_KEY,
                          inputDecoration: const InputDecoration(
                            hintText: Strings.txtHintLocation,
                            labelText: Strings.txtLocation,
                          ),
                          debounceTime: 800,
                          countries: const ["eg", "de"],
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            print("placeDetails${prediction.lng}");
                          },
                          itemClick: (Prediction prediction) {
                            _locationController.text = prediction.description!;
                            _locationController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: prediction.description!.length));
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        // Button to register
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade300,
                              ),
                              onPressed: () {},
                              child:  Text(
                                Strings.txtBtnSubmit,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: Settings.getFontFamilyAbel(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              Strings.txtHaveAcc,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                },
                                child: const Text(
                                  Strings.txtBtnLogin,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
