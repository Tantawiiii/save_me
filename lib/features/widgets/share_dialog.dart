import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:save_me/data/api_endpoints.dart';
import 'package:save_me/utils/constants/fonts.dart';
import 'package:save_me/utils/strings/Language.dart';
import 'package:share_plus/share_plus.dart';

GlobalKey globalKey = GlobalKey();

void shareDialog(context,
    {required Function onPressed, required String profileId}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          padding:
              const EdgeInsets.only(top: 4, right: 24, bottom: 4, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Language.instance.txtShareQr(),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                Language.instance.txtShareQrHint(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: Endpoints.publicProfileFrontEnd(profileId),
                    size: 240,
                    // embeddedImage: AssetImage("assets/images/logowithnobg.png"),
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size(40, 40),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Share.share(Endpoints.publicProfileFrontEnd(profileId),
                          subject: Language.instance.txtShareQrCheck());

                      if (Platform.isIOS || Platform.isAndroid) {
                        Fluttertoast.showToast(msg: "Profile copied to Share");
                      }
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
                    onTap: () {
                      _captureAndSavePng();
                    },
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
                      Clipboard.setData(ClipboardData(
                          text: Endpoints.publicProfileFrontEnd(profileId)));
                      if (Platform.isIOS || Platform.isAndroid) {
                        Fluttertoast.showToast(
                            msg: "Profile copied to clipboard");
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

String data = '';
bool dirExists = false;
dynamic externalDir = '/storage/emulated/0/Download/Qr_code';

Future<void> _captureAndSavePng() async {
  try {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);

    //Drawing White Background because Qr Code is Black
    final whitePaint = Paint()..color = Colors.white;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
    canvas.drawRect(
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        whitePaint);
    canvas.drawImage(image, Offset.zero, Paint());
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    //Check for duplicate file name to avoid Override
    String fileName = 'qr_code_saveMe';
    int i = 1;
    while (await File('$externalDir/$fileName.png').exists()) {
      fileName = 'qr_code_$i';
      i++;
    }

    // Check if Directory Path exists or not
    dirExists = await File(externalDir).exists();
    //if not then create the path
    if (!dirExists) {
      await Directory(externalDir).create(recursive: true);
      dirExists = true;
    }

    final file = await File('$externalDir/$fileName.png').create();
    await file.writeAsBytes(pngBytes);

    if (Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(
        msg: Language.instance.txtDeleteMsg(),
      );
    }
  } catch (e) {
    if (Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(
        msg: Language.instance.txtDeleteErrorMsg(),
      );
    }
  }
}
