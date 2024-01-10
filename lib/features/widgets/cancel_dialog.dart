import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:save_me/utils/constants/fonts.dart';
import 'package:save_me/utils/strings/Language.dart';

void cancelDialog(context, {required void Function() onPressed}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 320,
          padding:
              const EdgeInsets.only(top: 4, right: 24, bottom: 4, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Language.instance.txtCancelConfirm(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Language.instance.txtCancelConfirmHint(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Bounce(
                    duration: const Duration(milliseconds: 300),
                    onPressed: () {
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
                          Language.instance.txtDeleteNoBtn(),
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
                  const SizedBox(
                    height: 16,
                  ),
                  Bounce(
                    duration: const Duration(milliseconds: 300),
                    onPressed: onPressed,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: Colors.red.shade100,
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: Text(
                          Language.instance.txtCancelBtn(),
                          style: TextStyle(
                            color: Colors.red,
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
            ],
          ),
        );
      });
}
