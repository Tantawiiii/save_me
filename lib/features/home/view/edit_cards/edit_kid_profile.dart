// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';

import '../../../../data/api_client.dart';
import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';
import '../../../auth/models/user_model.dart';
import '../../../widgets/cancel_dialog.dart';
import '../../../widgets/loading_dialog.dart';
import '../../models/profile_info.dart';
import '../utils/image_picker_cropper.dart';

class EditKidProfile extends StatefulWidget {
  const EditKidProfile({super.key, required this.profileInfo});

  final ProfileInfo profileInfo;

  @override
  State<EditKidProfile> createState() => _EditKidProfileState();
}

class _EditKidProfileState extends State<EditKidProfile> {
  final formKey = GlobalKey<FormState>();
  bool uploading = false;
  File? image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _charController = TextEditingController();
  TextEditingController _behaviorController = TextEditingController();
  TextEditingController _specialCharController = TextEditingController();
  TextEditingController _medicinesController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _diseasesController = TextEditingController();
  TextEditingController _dietController = TextEditingController();
  TextEditingController _addInfoController = TextEditingController();

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
    _nameController = TextEditingController(text: widget.profileInfo.name);
    _addInfoController =
        TextEditingController(text: widget.profileInfo.additionalInformation);
    _ageController = TextEditingController(text: widget.profileInfo.age);
    _allergiesController =
        TextEditingController(text: widget.profileInfo.allergies);
    _behaviorController =
        TextEditingController(text: widget.profileInfo.behavior);
    _birthdayController =
        TextEditingController(text: widget.profileInfo.birthdate);
    _charController =
        TextEditingController(text: widget.profileInfo.characteristics);
    _dietController = TextEditingController(text: widget.profileInfo.diet);
    _diseasesController =
        TextEditingController(text: widget.profileInfo.diseases);
    _heightController = TextEditingController(text: widget.profileInfo.height);
    _weightController = TextEditingController(text: widget.profileInfo.weight);
    _medicinesController =
        TextEditingController(text: widget.profileInfo.medicines);
    _specialCharController =
        TextEditingController(text: widget.profileInfo.specialCharacteristics);

    return FutureBuilder(
        future: ApiClient.getUserProfileData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data as User?;
            return Scaffold(
              backgroundColor: ColorsCode.whiteColor,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                title: Column(
                  children: [
                    Text(
                      Language.instance.txtAppBarHome() + userData!.name ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      Language.instance.txtAppBarWelcome(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: Fonts.getFontFamilyTitillRegular(),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                toolbarHeight: 70,
                elevation: 8,
                shadowColor: Colors.black45,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Image(
                      image: AssetImage('assets/images/logowithnobg.png'),
                    ),
                  ),
                ),
                centerTitle: true,
                // backgroundColor: Theme.of(context).colorScheme.primary,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Container(
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
                            final isLastStep =
                                _currentStep == getSteps().length - 1;
                            if (isLastStep) {
                              setState(() => isCompleted = true);
                              _updateKidProfile(widget.profileInfo);
                              Navigator.pushReplacementNamed(context, "/home");
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
                              margin:
                                  const EdgeInsets.only(top: 32, bottom: 100),
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text(
                                        isLastStep
                                            ? Language.instance.txtUpdate()
                                            : Language.instance.txtNext(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: Fonts
                                              .getFontFamilyTitillSemiBold(),
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
                                          fontFamily: Fonts
                                              .getFontFamilyTitillSemiBold(),
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
                                      //details.onStepCancel,
                                      child: Text(
                                        Language.instance.txtCancel(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: Fonts
                                              .getFontFamilyTitillSemiBold(),
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
          return const Center(
            child: LoadingDialog(isLoading: true),
          );
        });
  }

  List<Step> getSteps() => [
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: Text(Language.instance.txtKidBasicInfo()),
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
                  child: image == null &&
                          (widget.profileInfo.photoUrl == null ||
                              widget.profileInfo.photoUrl == "null")
                      ? Center(
                          child:
                              SvgPicture.asset('assets/images/plus_gray.svg'),
                        )
                      : image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.profileInfo.photoUrl!,
                              width: 120,
                              height: 120,
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
                cursorColor: Colors.black,
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
          title: Text(Language.instance.txtKidBodyInfo()),
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

  void _updateKidProfile(ProfileInfo profileInfo) async {
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

    final profileUpdate = profileInfo.copyWith(
      name: name,
      additionalInformation: addInfo,
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
    );
    await updateProfile(widget.profileInfo.id!, profileUpdate);

    if (image != null) {
      await uploadProfileImage(
        image: image!,
        profileId: profileInfo.id!,
      );
    }
    if (Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: Language.instance.txtUpdateMsg());
    }
  }
}
