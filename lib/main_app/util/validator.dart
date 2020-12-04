
import 'package:flutter_app/main_app/resources/string_resources.dart';

class Validator {
  String nullFieldValidate(String value) =>
      value!=null && value !='' ? StringResources.thisFieldIsRequired : null;





  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return StringResources.pleaseEnterEmailText;
    }else if (!regex.hasMatch(value))
      return StringResources.pleaseEnterAValidEmailText;
    else
      return null;
  }

  String validatePassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
    );
    if (value.isEmpty) {
      return StringResources.thisFieldIsRequired;
    } else if (!_passwordRegExp.hasMatch(value)) {
      return StringResources.passwordMustBeSix;
    } else {
      return null;
    }
  }



  String validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return StringResources.passwordDoesNotMatch;
    } else {
      return null;
    }
  }


  String nameValidator(String value){
    Pattern pattern = '/[a-zA-Z]/i';
    RegExp regExp = new RegExp(pattern);
    if(value.length > 0){
      if(!regExp.hasMatch(value)){
        return StringResources.invalidName;
      }else{
        return null;
      }
    }else{
      return StringResources.thisFieldIsRequired;
    }
  }

}

