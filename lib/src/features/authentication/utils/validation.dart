

// This Class for a represent validation of Login and Register Screens
class Validation {

  static String? validateName(String value){
    if(value.isEmpty){
      return 'Please Enter Name';
    }
    return null;
  }

  static String? validateEmail(String value){
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern as String);

    if(!regExp.hasMatch(value)){
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 6 characters.';
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