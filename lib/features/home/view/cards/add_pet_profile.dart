// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:save_me/features/home/view/cards/created_done.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../widgets/cancel_dialog.dart';
import '../../api_helper/api_helper.dart';
import '../../models/profile_info.dart';
import '../utils/image_picker_cropper.dart';

class AddPetProfile extends StatefulWidget {
  const AddPetProfile({super.key});

  @override
  State<AddPetProfile> createState() => _AddPetProfileState();
}

class _AddPetProfileState extends State<AddPetProfile> {
  final formKey = GlobalKey<FormState>();
  File? image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _charController = TextEditingController();
  final TextEditingController _behaviorController = TextEditingController();
  final TextEditingController _specialCharController = TextEditingController();
  final TextEditingController _medicinesController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _diseasesController = TextEditingController();
  final TextEditingController _dietController = TextEditingController();
  final TextEditingController _addInfoController = TextEditingController();
  int _currentStep = 0;
  bool isCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    _birthdayController.text = "";
    super.initState();
  }

  // Picker Image for the current step
  Future<void> _pickAndCropImage() async {
    ImagePickerCropper imagePickerCropper = ImagePickerCropper();
    File? croppedImage = await imagePickerCropper.pickAndCropImage(context);

    if (croppedImage != null) {
      setState(() {
        image = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsCode.whiteColor,
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
                            Language.instance.txtPetCard(),
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
                            Language.instance.txtPetCardHint(),
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
                          final isLastStep =
                              _currentStep == getSteps().length - 1;
                          if (isLastStep) {
                            setState(() => isCompleted = true);
                            _addPetProfile();
                          } else {
                            setState(() => _currentStep += 1);
                          }
                        },
                        onStepTapped: (step) =>
                            setState(() => _currentStep = step),
                        onStepCancel: _currentStep == 0
                            ? null
                            : () => setState(() => _currentStep -= 1),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          final isLastStep =
                              _currentStep == getSteps().length - 1;
                          return Container(
                            margin: const EdgeInsets.only(top: 32, bottom: 100),
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
                                      isLastStep
                                          ? Language.instance.txtCreate()
                                          : Language.instance.txtNext(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            Fonts.getFontFamilyTitillSemiBold(),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_currentStep == 0)
                                  const SizedBox(width: 12),
                                if (_currentStep == 0)
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
                                const SizedBox(width: 12),
                                if (_currentStep != 0)
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
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: Text(Language.instance.txtPetBasicInfo()),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Language.instance.txtPhoto(),
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                    fontWeight: FontWeight.normal,
                    color: ColorsCode.grayColor100),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  _pickAndCropImage();
                },
                child: Container(
                  width: 148,
                  height: 89,
                  decoration: BoxDecoration(
                    color: ColorsCode.whiteColor100,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: image == null
                      ? Center(
                          child:
                              SvgPicture.asset('assets/images/plus_gray.svg'),
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
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
                    hintText: Language.instance.txtHintUserPet(),
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
                Language.instance.txtBirthday(),
                style: TextStyle(
                    fontSize: 14,
                    color: ColorsCode.grayColor100,
                    fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _birthdayController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorsCode.whiteColor100,
                  suffixIcon: const Icon(Icons.date_range),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.purple.shade100,
                  )),
                  hintText: Language.instance.txtHintBirthday(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.getFontFamilyTitillRegular(),
                    color: ColorsCode.grayColor,
                  ),
                  //isDense: true,
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.black12,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Colors.black, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      });

                  if (pickedDate != null) {
                    if (kDebugMode) {
                      print(pickedDate);
                    }
                    String formattedDate =
                        DateFormat(Language.instance.txtDatePattern())
                            .format(pickedDate);

                    setState(() {
                      _birthdayController.text = formattedDate;
                    });
                  } else {
                    if (kDebugMode) {
                      print('Bug Formatted');
                    }
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtAge(),
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
                  controller: _ageController,
                  keyboardType: TextInputType.number,
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
                    hintText: Language.instance.txtPetAgeHint(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          // Body info Ui Design and Implementation
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: Text(Language.instance.txtPetBodyInfo()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Language.instance.txtWeight(),
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
                  controller: _weightController,
                  keyboardType: TextInputType.number,
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
                    hintText: Language.instance.txtKg(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtHeight(),
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
                  controller: _heightController,
                  keyboardType: TextInputType.number,
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
                    hintText: Language.instance.txtCm(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtCharacteristics(),
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
                  controller: _charController,
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
                    hintText: Language.instance.txtPetHintCharacteristics(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtBehavior(),
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
                  controller: _behaviorController,
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
                    hintText: Language.instance.txtPetHintBehavior(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtSpecialChar(),
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
                  controller: _specialCharController,
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
                    hintText: Language.instance.txtPetHintSpecialChar(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: Text(Language.instance.txtPetHealthInfo()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Language.instance.txtMedicines(),
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
                  controller: _medicinesController,
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
                    hintText: Language.instance.txtPetHintMedicines(),
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
                Language.instance.txtAllergies(),
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
                  controller: _allergiesController,
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
                    hintText: Language.instance.txtPetHintAllergies(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtDiet(),
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
                  controller: _dietController,
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
                    hintText: Language.instance.txtPetHintDiet(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Language.instance.txtDiseases(),
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
                  controller: _diseasesController,
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
                    hintText: Language.instance.txtPetHitDiseases(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
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
                    hintText: Language.instance.txtPetHintAdditionInfo(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];

  void _addPetProfile() async {
    // Implement your Profile logic here
    final name = _nameController.text;
    final birthday = _birthdayController.text;
    final age = _ageController.text;
    final weight = _weightController.text;
    final height = _heightController.text;
    final character = _charController.text;
    final behavior = _behaviorController.text;
    final specialChar = _specialCharController.text;
    final medication = _medicinesController.text;
    final allergies = _allergiesController.text;
    final diet = _dietController.text;
    final diseases = _diseasesController.text;
    final addInfo = _addInfoController.text;

    final profileInfo = ProfileInfo(
        profileType: "PET",
        photoUrl: "",
        name: name,
        birthdate: birthday,
        age: age,
        weight: weight,
        height: height,
        characteristics: character,
        behavior: behavior,
        specialCharacteristics: specialChar,
        medicines: medication,
        allergies: allergies,
        diet: diet,
        diseases: diseases,
        additionalInformation: addInfo);

    final createProfileSuccess = await postProfileData(profileInfo);

    if (createProfileSuccess != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (image != null) {
        await uploadProfileImage(
          image: image!,
          profileId: createProfileSuccess.id!,
        );
      }
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
