
import '../../../../constants/Strings.dart';


class Validation {

  static String? validateName(String value){
    if(value.isEmpty){
      return Strings.txtIsEmptyName;
    }
    return null;
  }

  static String? validateEmail(String value){
    Pattern pattern = Strings.patternEmail;
    RegExp regExp = RegExp(pattern as String);

    if(value.isEmpty){
      return Strings.txtIsEmptyEmail;
    }
    if(!regExp.hasMatch(value)){
      return Strings.txtNotValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = Strings.patternPassword;
    RegExp regex =  RegExp(pattern as String);
    if(value.isEmpty){
      return Strings.txtHintPassword;
    }
    if (!regex.hasMatch(value)) {
      return Strings.txtPasswordMatch;
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