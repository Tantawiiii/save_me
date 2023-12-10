
import 'package:save_me/utils/strings/Language.dart';

import '../../../utils/strings/Strings_en.dart';


class Validation {

  static String? validateName(String value){
    if(value.isEmpty){
      return Language.instance.txtIsEmptyName();
    }
    return null;
  }

  static String? validateEmail(String value){
    Pattern pattern = StringsEn.patternEmail;
    RegExp regExp = RegExp(pattern as String);
    if(value.isEmpty){
      return Language.instance.txtIsEmptyEmail();
    }
    if(!regExp.hasMatch(value)){
      return Language.instance.txtNotValidEmail();
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = StringsEn.patternPassword;
    RegExp regex =  RegExp(pattern as String);
    if(value.isEmpty){
      return Language.instance.txtHintPassword();
    }

    if (!regex.hasMatch(value)) {
      return Language.instance.txtPasswordMatch();
    } else {
      return null;
    }
  }

/*

static String? validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[_\W]){1,})(?!.*\s).{8,}$';
  RegExp regex = RegExp(pattern);

  if (value.isEmpty) {
    return Language.instance.txtHintPassword();
  }

  if (!regex.hasMatch(value)) {
    return Language.instance.txtPasswordMatch();
  } else {
    return null;
  }
}

 */

  static String? validatePhoneNumber(String value){
    if(value.length != 11){
      return 'Mobile Number must be of 11 digit';
    } else if (value.isEmpty){
      return 'Not require';
    } else{
      return null;
    }

  }




}