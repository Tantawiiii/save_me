import 'dart:ui';

class ColorsCode{
  static Color  blackColor = hexToColor('#00000000');
  static Color  blackColor100 = hexToColor('#1E1E1E');
  static Color  blackColor700 = hexToColor('#373737');
  static Color  whiteColor = hexToColor('#FFFFFF');
  static Color  whiteColor100 = hexToColor('#F1F1F1');
  static Color  whiteColor300 = hexToColor('#E3E3E3');
  static Color  grayColor = hexToColor('#8A8A8A');
  static Color  grayColor100 = hexToColor('#6D6D6D');
  static Color  grayColor300 = hexToColor('#515151');
  static Color  purpleColor = hexToColor('#BE0ED5');
  static Color purpleColorBright = hexToColor('#C426D9');
  static Color purpleColorLight = hexToColor('#F0DEF2');

}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
