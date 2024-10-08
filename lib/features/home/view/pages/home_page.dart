import 'package:flutter/material.dart';
import 'package:save_me/features/home/api_helper/api_helper.dart';
import 'package:save_me/features/home/models/profile_info.dart';
import 'package:save_me/features/widgets/loading_dialog.dart';

import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';

import '../ui/item_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ProfileInfo>>(
          future: getUserProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isEmpty ?? true) {
                return Center(
                  child: Text(
                    Language.instance.txtStartAddProfile(),
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: Fonts.getFontFamilyTitillBold(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final profile = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.all(14),
                    child: ItemCard(profileInfo: profile),
                  );
                },
              );
            }
            return const Center(
              child: LoadingDialog(isLoading: true),
              // CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
            );
          }),
    );
  }
}
