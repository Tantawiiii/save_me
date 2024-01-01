// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:save_me/features/home/view/cards/created_done.dart';
import 'package:save_me/features/widgets/cancel_dialog.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../auth/utils/validation.dart';
import '../../api_helper/api_helper.dart';
import '../../models/profile_info.dart';

class AddItemProfile extends StatefulWidget {
  const AddItemProfile({super.key});

  @override
  State<AddItemProfile> createState() => _AddItemProfileState();
}

class _AddItemProfileState extends State<AddItemProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addInfoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCode.whiteColor,
      resizeToAvoidBottomInset: false,
      body: isCompleted
          ? const Center(
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
                            Language.instance.txtItemCard(),
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
                            Language.instance.txtItemCardHint(),
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
                            if (kDebugMode) {
                              print('Completed');
                            }
                            _addItemProfile();
                          } else {
                            setState(() => _currentStep += 1);
                          }
                        },
                        onStepTapped: (step) =>
                            setState(() => _currentStep = step),
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
                                      backgroundColor: Colors.black,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      Language.instance.txtCreate(),
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
                                  onTap: () {
                                    cancelDialog(context, onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/home");
                                    });
                                  },
                                  child: Text(
                                    Language.instance.txtCancel(),
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
          title: Text(Language.instance.txtItemBasicInfo()),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Language.instance.txtName(),
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
                  cursorColor: Colors.black,
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
                    hintText: Language.instance.txtHintUserItem(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                    //isDense: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtAdditionInfo(),
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
                  controller: _addInfoController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black,
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
                    hintText: Language.instance.txtItemHintAdditionInfo(),
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

  void _addItemProfile() async {
    // Implement your Profile logic here
    final name = _nameController.text;
    final addInfo = _addInfoController.text;

    if (kDebugMode) {
      print('Name: $name');
      print('addInfo: $addInfo');
    }

    final profileInfo = ProfileInfo(
        profileType: "ITEM", name: name, additionalInformation: addInfo);

    final createProfileSuccess = await postProfileData(profileInfo);

    if (createProfileSuccess != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (kDebugMode) {
        print("Success Uploading profile information's and added it to Home");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $createProfileSuccess'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
