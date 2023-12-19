// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:save_me/utils/strings/Strings_en.dart';

import '../../../data/api_client.dart';
import '../../../utils/constants/colors_code.dart';
import '../../../utils/constants/fonts.dart';
import '../../../utils/strings/Language.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_dialog.dart';
import '../Screens/login_screen.dart';
import '../models/user_model.dart';
import '../utils/validation.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  // to get a location data when user change here location
  String locationName = "";
  double latitude = 0.0;
  double longitude = 0.0;

  final _phoneNumberController = TextEditingController();
  String parsedPhoneNumber = '';
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');
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

  int _currentStep = 0;

  //check completeness of inputs
  bool isCompleted = false;

  // Handel a Loading bar when the translate a language.
  bool isLoading = false;

  void _handleButtonClick() {
    // Set loading to true to show the loading indicator
    setState(() {
      isLoading = true;
    });

    // Simulate a 1-second delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    return Scaffold(
      backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
          //primarySwatch: Colors.cyan,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.purple,
                background: Colors.white38,
                secondary: Colors.purple,
              ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // this is the visible a skip text in second Step
                  _currentStep >= 1
                      ? Container(
                          margin: const EdgeInsets.only(right: 24),
                          child: InkWell(
                            onTap: () {
                              _handleButtonClick();
                              _register();
                            },
                            child: Text(
                              Language.instance.txtSkip(),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: Fonts.getFontFamilyTitillRegular(),
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 24,
                        ),
                  Expanded(
                    child: Stepper(
                      elevation: 0,
                      type: StepperType.horizontal,
                      steps: _getSteps(),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        final isLastStep =
                            _currentStep == _getSteps().length - 1;
                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(top: 56),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: details.onStepContinue,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: Text(
                                            isLastStep
                                                ? Language.instance
                                                    .txtGetStarted()
                                                : Language.instance.txtNext(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: Fonts
                                                  .getFontFamilyTitillSemiBold(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Language.instance.txtHaveAcc(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillRegular(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Bounce(
                                      duration:
                                          const Duration(milliseconds: 150),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
                                      },
                                      child: Text(
                                        Language.instance.txtButtonLogin(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: Fonts
                                                .getFontFamilyTitillSemiBold(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      currentStep: _currentStep,
                      onStepTapped: (steps) {
                        setState(() {
                          _currentStep = steps;
                        });
                      },
                      onStepContinue: () {
                        setState(() {
                          if (_currentStep < 1) {
                            if (_validateCurrentStep()) {
                              _currentStep += 1;
                              if (kDebugMode) {
                                print('register step 1');
                              }
                            }
                            if (kDebugMode) {
                              print('register step 2');
                            }
                          } else {
                            if (kDebugMode) {
                              print('register step 3');
                            }
                            _handleButtonClick();
                            _register();
                          }
                        });
                      },
                      onStepCancel: () {
                        if (_currentStep == 0) {
                          null;
                        } else {
                          setState(() {
                            _currentStep -= 1;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            LoadingDialog(isLoading: isLoading),
          ],
        ),
      ),
    );
  }

  List<Step> _getSteps() => [
        Step(
          title: Text(Language.instance.txtRegisterNow()),
          content: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey1,
            child: Column(
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
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _emailController,
                  labelText: Language.instance.txtEmail(),
                  hintText: Language.instance.txtHintEmail(),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validation.validateEmail(value ?? "");
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  labelText: Language.instance.txtPassword(),
                  hintText: Language.instance.txtHintPassword(),
                  obscureText: passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    return Validation.validatePassword(value ?? "");
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: Language.instance.txtConfirmPassword(),
                  hintText: Language.instance.txtHintConfirmPassword(),
                  obscureText: passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Language.instance.txtHintConfirmPassword();
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return Language.instance.txtNotMatchPassword();
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text(Language.instance.txtCompleteProfile()),
          content: Form(
            key: _formKey2,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
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
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
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
                        hintText: Language.instance.txtHintUserName(),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: Fonts.getFontFamilyTitillRegular(),
                          color: ColorsCode.grayColor,
                        ),
                        //isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    Language.instance.txtLocation(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: Fonts.getFontFamilyTitillRegular(),
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Auto Located Place
                  SizedBox(
                    height: 56,
                    child: GooglePlaceAutoCompleteTextField(
                      isCrossBtnShown: false,
                      textEditingController: _locationController,
                      googleAPIKey: StringsEn.API_KEY_Google,
                      boxDecoration: BoxDecoration(
                        color: ColorsCode.whiteColor100,
                      ),
                      inputDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 6,
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, top: 3, bottom: 3, right: 8),
                          child: Icon(
                            Icons.my_location_outlined,
                            size: 24,
                          ),
                        ),
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
                        hintText: Language.instance.txtHintLocation(),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: Fonts.getFontFamilyTitillRegular(),
                          color: ColorsCode.grayColor,
                        ),
                      ),
                      debounceTime: 800,
                      countries: const ["eg", "de"],
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        if (kDebugMode) {
                          print("placeDetails${prediction.lng}");
                        }
                      },
                      itemClick: (Prediction prediction) {
                        // TODO: Error Location Lat , Long
                        // Handle the location details directly in the itemClick callback
                        locationName = prediction.description ?? "";
                        // Use try-catch to handle potential casting errors
                        try {
                          // Attempt to parse lat and lng as double
                          latitude = double.parse(prediction.lat?.toString() ?? "0.0");
                          longitude = double.parse(prediction.lng?.toString() ?? "0.0");

                        } catch (e) {
                          if (kDebugMode) {
                            print("Error parsing lat/lng: $e");
                            print("Problematic values - lat: ${prediction.lat}, lng: ${prediction.lng}");

                          }
                          // Handle the error case, set default values if needed
                          latitude = 0.0;
                          longitude = 0.0;
                        }
                        _locationController.text = locationName;
                        _locationController.selection = TextSelection.fromPosition(
                          TextPosition(offset: locationName.length),
                        );

                      },
                    ),
                  ),
                  const SizedBox(height: 24),
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
                      border: Border.all(color: Colors.black.withOpacity(0.13)),
                    ),
                    child: InternationalPhoneNumberInput(
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      initialValue: number,
                      ignoreBlank: false,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      textFieldController: _phoneNumberController,
                      formatInput: false,
                      //maxLength: 11,
                      spaceBetweenSelectorAndTextField: 0,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true,),
                      cursorColor: Colors.black,
                      inputDecoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 15, left: 8),
                        border: InputBorder.none,
                        hintText: Language.instance.txtHintPhoneNumber(),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: Fonts.getFontFamilyTitillRegular(),
                          color: ColorsCode.grayColor,
                        ),
                      ),
                      onInputChanged: (PhoneNumber value) {
                       // String countryCode = value.dialCode ?? " ";
                        // TODO: Fixed to get country code with entered Phone number
                        parsedPhoneNumber = value.phoneNumber ?? "";

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _formKey1.currentState?.validate() ?? false;
      case 1:
        return _formKey2.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  void _register() async {
    try {
      // Implement your registration logic here
      final email = _emailController.text;
      final password = _passwordController.text;
      final name = _nameController.text;
      final location = _locationController.text;

      if (kDebugMode) {
        print('Name: $name');
        print('Email: $email');
        print('Password: $password');
        print('PhoneNumber: $parsedPhoneNumber');
        print('location: $locationName');
        print('lat: $latitude');
        print('long: $longitude');
      }

      LoadingDialog(isLoading: isLoading);
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        location: Location(
          name: locationName,
          latitude: latitude.toString(),
          longitude: longitude.toString(),
        ),
        phoneNumber: parsedPhoneNumber,
      );

      String registerSuccessful = await ApiClient().registerUser(user);

      if (kDebugMode) {
        print(registerSuccessful);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Register failed: $e ");
      }
    }
  }
}
