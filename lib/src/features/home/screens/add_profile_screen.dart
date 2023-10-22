import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_me/constants/Strings.dart';

// list for Selection menu
const List<String> list = <String>[
  'Senior',
  'kid',
  'Disabled Person',
  'Pet',
  'item'
];

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  String selectMenuValue = list.first;

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  int _currentStep = 0;
  bool isCompleted = false;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.txtAddProfile,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black54,
            ),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.only(right: 8),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.txtChooseProfile,
                          style: TextStyle(
                            fontSize: 16,
                            // fontFamily: Settings.getFontFamilyCairo(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DropdownMenu(
                    controller: _typeController,
                    initialSelection: list.first,
                    label: const Text(Strings.txtType),
                    width: 350,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectMenuValue = value!;
                      });
                    },
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Stepper(
                physics: const ClampingScrollPhysics(),
                type: StepperType.vertical,
                steps: getSteps(),
                currentStep: _currentStep,
                onStepContinue: () {
                  final isLastStep = _currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    setState(() => isCompleted = true);
                    print('Completed');
                  } else {
                    setState(() => _currentStep += 1);
                  }
                },
                onStepTapped: (step) => setState(() => _currentStep = step),
                onStepCancel: _currentStep == 0
                    ? null
                    : () => setState(() => _currentStep -= 1),
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
          title: const Text(Strings.txtBasicInfo),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                Strings.txtBasicInfoHint,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 0.1, style: BorderStyle.none),
                  ),
                  labelText: Strings.txtName,
                  hintText: Strings.txtName,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _dateController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: Strings.txtDatePattern,
                  icon: Icon(Icons.calendar_today),
                  labelText: Strings.txtBirthday,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat(Strings.txtDatePattern).format(pickedDate);
                    print(pickedDate);

                    setState(() {
                      _dateController.text = formattedDate;
                    });
                  } else {
                    print('Bug Formatted');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementCounter,
                    ),
                    Text(
                      'Age:  $_counter',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementCounter,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Step(
          // Body info Ui Design and Implementation
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: const Text(Strings.txtBodyInfo),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.txtBodyInfoHint,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(width: 0.1, style: BorderStyle.none),
                        ),
                        labelText: Strings.txtSize,
                        hintText: Strings.txtSize,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(width: 0.1, style: BorderStyle.none),
                        ),
                        labelText: Strings.txtWeight,
                        hintText: Strings.txtKg,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(width: 0.1, style: BorderStyle.none),
                        ),
                        labelText: Strings.txtHeight,
                        hintText: Strings.txtCm,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText:Strings.txtCharacteristics ,
                    hintText: Strings.txtCharacteristics,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtBehavior,
                    hintText: Strings.txtBehavior,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtSpecialChar,
                    hintText: Strings.txtSpecialChar,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text(Strings.txtHealthInfo),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.txtHealthInfoHint,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtDiet,
                    hintText: Strings.txtDiet,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtAllergies,
                    hintText: Strings.txtAllergies,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtDiseases,
                    hintText: Strings.txtDiseases,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtMedicines,
                    hintText: Strings.txtMedicines,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: Strings.txtAdditionInfo,
                    hintText: Strings.txtAdditionInfo,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
}
