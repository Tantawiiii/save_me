
import '../../../constants/strings/Strings_en.dart';


class Validation {

  static String? validateName(String value){
    if(value.isEmpty){
      return StringsEn.txtIsEmptyName;
    }
    return null;
  }

  static String? validateEmail(String value){
    Pattern pattern = StringsEn.patternEmail;
    RegExp regExp = RegExp(pattern as String);

    if(value.isEmpty){
      return StringsEn.txtIsEmptyEmail;
    }
    if(!regExp.hasMatch(value)){
      return StringsEn.txtNotValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = StringsEn.patternPassword;
    RegExp regex =  RegExp(pattern as String);
    if(value.isEmpty){
      return StringsEn.txtHintPassword;
    }
    if (!regex.hasMatch(value)) {
      return StringsEn.txtPasswordMatch;
    } else {
      return null;
    }
  }

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