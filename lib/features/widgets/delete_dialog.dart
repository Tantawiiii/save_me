import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:save_me/utils/constants/fonts.dart';

void deleteDialog(context, {required dynamic onPressed}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.only(top:4,right: 24,bottom: 4,left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Delete Confirmation",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(height:12,),
              Text(
                "Are you sure you want to delete this profile? This action is irreversible, and all your data will be permanently lost.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(height: 28,),
              Bounce(
                duration: const Duration(milliseconds:300),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "No, I don’t want",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18,),
              Bounce(
                duration: const Duration(milliseconds:300),
                //TODO: fIX ME Delete this profile

                onPressed: onPressed(),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.redAccent,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "Yes, Delete this profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
