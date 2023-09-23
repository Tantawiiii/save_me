

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Welcome to SaveMee',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Here We Can Help You To Find Your Lost Items',
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
                          decoration:   InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Name',
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
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'User Name',
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
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Phone Number',
                          ),
                          validator: (value) {
                            return Validation.validatePhoneNumber(value ?? "");
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
                              labelText: 'Email',
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
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Password',
                            hintText: 'please enter password',
                          ),
                          validator: (value) {
                            return Validation.validateEmail(value ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Confirm Password',
                            hintText: 're-enter password',
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Please re-enter password';
                            }
                            if(_passwordController.text != _confirmPasswordController.text){
                              return "Password does not match";
                            }
                            return null;
                          },
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
