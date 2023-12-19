import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:save_me/data/api_endpoints.dart';
import 'package:save_me/utils/constants/fonts.dart';
import 'package:share_plus/share_plus.dart';

void shareDialog(context, {required Function onPressed, required String profileId}) {
  //TODO: fIX ME

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          padding: const EdgeInsets.only(top: 4, right: 24, bottom: 4, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Scan this QR code",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "This unique QR code is linked to this profile. Scanning it will only provide access to this profile.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              //TODO: fIX ME  qr code

              Center(
                child: QrImageView(
                  data: Endpoints.publicProfileFrontEnd(profileId),
                  size: 240,
                  // embeddedImage: AssetImage("assets/images/logowithnobg.png"),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(45, 45),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Share.share(Endpoints.publicProfileFrontEnd(profileId), subject: "Check out this profile");
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/share.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/images/icons/download.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: Endpoints.publicProfileFrontEnd(profileId)));
                      if (Platform.isIOS) {
                        Fluttertoast.showToast(msg: "Profile copied to clipboard");
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/copy.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
