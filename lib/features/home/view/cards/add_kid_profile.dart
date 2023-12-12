// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';

import 'package:save_me/features/home/view/cards/created_done.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../models/profile_info.dart';



@RoutePage()
class AddKidProfile extends StatefulWidget {
  const AddKidProfile({super.key});

  @override
  State<AddKidProfile> createState() => _AddKidProfileState();
}

class _AddKidProfileState extends State<AddKidProfile> {

  final formKey = GlobalKey<FormState>();


  File? _image;
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
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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
                      Language.instance.txtKidCard(),
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
                      Language.instance.txtKidCardHint(),
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
                    final isLastStep = _currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      setState(() => isCompleted = true);
                      if (kDebugMode) {
                        print('Completed');
                      }
                      print('Success added to state');
                      _addChildProfile();
                    } else {
                      setState(() => _currentStep += 1);
                    }
                  },
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepCancel: _currentStep == 0
                      ? null
                      : () => setState(() => _currentStep -= 1),
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    final isLastStep = _currentStep == getSteps().length - 1;
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
                          if (_currentStep != 0) const SizedBox(width: 12),
                          if (_currentStep != 0)
                            InkWell(
                              onTap: details.onStepCancel,
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
          title:  Text(Language.instance.txtKidBasicInfo()),
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
                  _pickImage();
                },
                child: Container(
                  width: 148,
                  height: 89,
                  decoration: BoxDecoration(
                    color: ColorsCode.whiteColor100,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: _image == null
                      ? Center(
                          child: SvgPicture.asset('assets/images/plus_gray.svg'),
                        )
                      : Image.file(
                          _image!,
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
                      builder: (context,child){
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.black12,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme:TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, // button text color
                              ),
                            ),
                          ), child:child!,
                        );
                      }
                  );

                  if (pickedDate != null) {
                    if (kDebugMode) {
                      print(pickedDate);
                    }
                    String formattedDate =
                        DateFormat(Language.instance.txtDatePattern()).format(pickedDate);
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
                    hintText: Language.instance.txtKidAgeHint(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                    //isDense: true,
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
          title:  Text(Language.instance.txtKidBodyInfo()),
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
                    //isDense: true,
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
                    //isDense: true,
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
                    hintText: Language.instance.txtHintCharacteristics(),
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
                    hintText: Language.instance.txtHintBehavior(),
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
                    hintText: Language.instance.txtHintSpecialChar(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                    //isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: Text(Language.instance.txtHealthInfo()),
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
                    hintText: Language.instance.txtHintMedicines(),
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
                    hintText: Language.instance.txtHintAllergies(),
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
                    hintText: Language.instance.txtHintDiet(),
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
                    hintText: Language.instance.txtHitDiseases(),
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
                    hintText: Language.instance.txtHintAdditionInfo(),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.getFontFamilyTitillRegular(),
                      color: ColorsCode.grayColor,
                    ),
                    //isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ];


  void _addChildProfile() async {
    // Implement your Profile logic here
    final photo = _image;
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

    if (kDebugMode) {
      print('photo: $photo');
      print('Name: $name');
      print('birthday: $birthday');
      print('age: $age');
      print('weight: $weight');
      print('height: $height');
      print('character: $character');
      print('behavior: $behavior');
      print('specialChar: $specialChar');
      print('medication: $medication');
      print('allergies: $allergies');
      print('diet: $diet');
      print('diseases: $diseases');
      print('addInfo: $addInfo');
    }

   // LoadingDialog(isLoading: isLoading);

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Progress to Add Data'),
    //   backgroundColor: Colors.blueAccent,
    // ));

    final profileInfo = ProfileInfo(
      profileType: "KID",
      photoUrl: _image,
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
      additionalInformation: addInfo
    );


    final createProfileSuccess = await postProfileData(profileInfo);

    if (createProfileSuccess) {
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
