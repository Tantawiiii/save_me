import 'package:flutter/material.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/cards/craeted_done.dart';

import '../../auth/utils/validation.dart';

class AddItemProfile extends StatefulWidget {
  const AddItemProfile({super.key});

  @override
  State<AddItemProfile> createState() => _AddItemProfileState();
}

class _AddItemProfileState extends State<AddItemProfile> {
  final TextEditingController _nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
   int _currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCode.whiteColor,
      body: isCompleted ?
      const Center(
              child: CreatedProfile(),
            )
          : Container(
              margin: const EdgeInsets.only(
                top: 0.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            Strings.txtItemCard,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: Fonts.getFontFamilyTitillBold(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            Strings.txtItemCardHint,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Fonts.getFontFamilyTitillRegular(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context)
                            .colorScheme
                            .copyWith(primary: ColorsCode.purpleColor),
                      ),
                      child: Stepper(
                        physics: const ClampingScrollPhysics(),
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: _currentStep,
                        onStepContinue: () {
                          final isLastStep = _currentStep == 0;
                          if (isLastStep) {
                            setState(() => isCompleted = true);
                            print('Completed');
                          } else {
                            setState(() => _currentStep += 1);
                          }
                        },
                        onStepTapped: (step) => setState(() => _currentStep = step),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Container(
                            margin: const EdgeInsets.only(top: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 56,
                                  width: 155,
                                  child: ElevatedButton(
                                    onPressed: details.onStepContinue,
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                       "Create",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillSemiBold(),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                               const SizedBox(width: 12),
                                  InkWell(
                                    onTap: details.onStepCancel,
                                    child: Text(
                                      Strings.txtCancel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillSemiBold(),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: _currentStep == 0,
          title: const Text(Strings.txtItemBasicInfo),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.txtName,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                    fontWeight: FontWeight.normal,
                    color: ColorsCode.grayColor100),
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
                    hintText: Strings.txtHintUserItem,
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
                height: 16,
              ),
              Text(
                Strings.txtAdditionInfo,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                    fontWeight: FontWeight.normal,
                    color: ColorsCode.grayColor100),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                child: TextFormField(
                  //controller: _nameController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
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
                    hintText: Strings.txtItemHintAdditionInfo,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                    //isDense: true,
                  ),
                  // validator: (value) {
                  //   return Validation.validateEmail(value ?? "");
                  // },
                ),
              ),
            ],
          ),
        ),
      ];
}
