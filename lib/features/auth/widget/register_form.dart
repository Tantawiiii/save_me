// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:save_me/constants/fonts.dart';
import '../../../../constants/Strings.dart';
import '../Screens/home_screen.dart';
import '../Screens/login_screen.dart';
import '../dataSource/api_client.dart';
import '../models/user_model.dart';
import '../utils/validation.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Initialize Dio with ApiClient
  final ApiClient _apiClient = ApiClient();


  static const _steps = [
    Step(
      title: Text('Register Now'),
      content: _RegisterNowForm(),
    ),
    Step(
      title: Text('Complete Profile'),
      content: _CompleteProfileForm(),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _registerUserFun() async {
      // to implement a register
      if (_formKey.currentState!.validate()) {
        String name = _nameController.text;
        String username = _usernameController.text;
        String email = _emailController.text;
        String password = _passwordController.text;
        String phoneNumber = _phoneNumController.text;
        String location = _locationController.text;

        if (kDebugMode) {
          print('Name: $name');
          print('Username: $username');
          print('Email: $email');
          print('Password: $password');
          print('PhoneNumber: $phoneNumber');
          print('location: $location');
        }

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Progress to Add Data'),
          backgroundColor: Colors.blueAccent,
        ));

        final user = User(
          name: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phoneNumController.text,
          location: _locationController.text,
        );

        final registerSuccessful = await _apiClient.registerUser(user);

        if (registerSuccessful) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: $registerSuccessful'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
          //primarySwatch: Colors.cyan,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.purple,
            background: Colors.white38,
            secondary: Colors.purple,
          )
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Stepper(
            elevation: 0,
                type: StepperType.horizontal,
                steps: _steps,
              ),
        ),
      ),
    );
  }
}

class _RegisterNowForm extends StatefulWidget {
  const _RegisterNowForm({super.key});

  @override
  State<_RegisterNowForm> createState() => _RegisterNowFormState();
}

class _RegisterNowFormState extends State<_RegisterNowForm> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =  TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // Initialize Dio with ApiClient
  final ApiClient _apiClient = ApiClient();
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
      ],
    );
  }
}

// _CompleteProfileForm
class _CompleteProfileForm extends StatefulWidget {
  const _CompleteProfileForm({super.key});

  @override
  State<_CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<_CompleteProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          //controller: _emailController,
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
         // controller: _passwordController,
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
          //controller: _confirmPasswordController,
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
            // if (_passwordController.text !=
            //     _confirmPasswordController.text) {
            //   return Strings.txtNotMatchPassword;
            // }
            return null;
          },
        ),
      ],
    );
  }
}


