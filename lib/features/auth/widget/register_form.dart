// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/auth/widget/complete_profile_form.dart';
import 'package:save_me/features/auth/widget/register_now_form.dart';
import '../../../../constants/Strings.dart';
import '../../home/home_screen.dart';
import '../Screens/login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  static String id = 'RegisterScreen';
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  int currentStep  = 0;
  bool isCompleted = false; //check completeness of inputs

 List <Step> _getSteps() => [
    Step(
      title: const Text('Register Now'),
      content: const RegisterNowForm() ,
      isActive: currentStep >=0,
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
    ),
   Step(
      isActive: currentStep >=1,
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text('Complete Profile'),
      content: const CompleteProfileForm(),
    ),
  ];

 // is Details Complete
  bool _isDetailsComplete() {
    if (currentStep == 0 ) {}
    else if (currentStep == 1){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage()),
      );
    }
        return false;
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
                )),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Form(
            //key: formKey,
            child: Stepper(
              elevation: 0,
              type: StepperType.horizontal,
              steps: _getSteps(),
              //  to Customise Stepper Buttons.
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLastStep = currentStep == _getSteps().length - 1;
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
                                      primary: Colors.black,
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      isLastStep ? "Get Started" : "Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                    ),
                                    ),
                                  ),
                                ),
                            ),
                            const SizedBox(width: 4),
                            if (currentStep != 0)
                            Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: details.onStepCancel,
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                      elevation: 0,
                                    ),
                                    child: const Text('Skip'),
                                  ),
                                ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24,),
                        Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              Strings.txtHaveAcc,
                              style: TextStyle(
                                fontSize: 18,
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
                                      const LoginScreen()),
                                );
                              },
                              child: Text(
                                Strings.txtButtonLogin,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              currentStep: currentStep,
              onStepTapped: (steps){
                setState(() {
                  currentStep = steps;
                });
              },
              onStepContinue: (){
                final isLastStep = currentStep == _getSteps().length - 1;
                //this check if ok to move on to next screen
                bool isDetailValid = _isDetailsComplete();
                if (isDetailValid) {
                  if (isLastStep) {
                    setState(() {
                      isCompleted = true;
                    });
                  } else {
                    currentStep += 1;
                  }
                }

                if (!isLastStep) {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: (){
                if (currentStep == 0) {
                  null;
                }  else{
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
