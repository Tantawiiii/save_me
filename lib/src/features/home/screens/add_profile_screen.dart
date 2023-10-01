import 'package:flutter/material.dart';
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
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
                  initialSelection: list.first,
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
          ],
        ),
      ),
    );
  }
}
