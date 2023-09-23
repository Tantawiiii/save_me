import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Screens/register_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                'Welcome Back !',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "cairo",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Here We Can Help You To Find Your Lost Items',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "cairo",
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
                      decoration: const InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email)),
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
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        return Validation.validatePassword(value ?? "");
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              if (kDebugMode) {
                                print('Email: $email');
                              }
                              if (kDebugMode) {
                                print('Password: $password');
                              }
                            }
                          },
                          child: const Text(
                            "Let's Go",
                            style:
                            TextStyle(color: Colors.black,
                              fontSize: 16,
                              fontFamily: "abel",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Don't Have Account ?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) => const RegisterScreen()
                                  ),
                              );
                            },
                            child: const Text(
                              'Register',
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
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
