import '/core/utils/const_value_manager.dart';
import '/core/utils/string_manager.dart';

import '../utils/const_value_manager.dart';

class Validator {
  /// password validator
  static List validatePassword(String password) {
    // Contains at least one uppercase letter
    final RegExp uppercaseLetterRegExp = RegExp(r'[A-Z]');
    // Contains at least one lowercase letter
    final RegExp lowercaseLetterRegExp = RegExp(r'[a-z]');
    // Contains at least one digit
    final RegExp digitRegExp = RegExp(r'[0-9]');
    // Contains at least one special character
    final RegExp specialCharacterRegExp = RegExp(r'[!@#%^&*(),.?":{}|<>]');


  for(ConditionPasswordItem element in  ConstValueManager.conditionPasswordList)
    element.isValidate=false;
    if (password.length >= 8) {
      ConstValueManager.conditionPasswordList[0].isValidate = true;

    }
    if (password.contains(uppercaseLetterRegExp)&&password.contains(lowercaseLetterRegExp)) {

      ConstValueManager.conditionPasswordList[1].isValidate = true;

    }
    if (password.contains(digitRegExp)) {

      ConstValueManager.conditionPasswordList[2].isValidate = true;
    }
    if (password.contains(specialCharacterRegExp)) {

      ConstValueManager.conditionPasswordList[3].isValidate = true;
    }
    return ConstValueManager.conditionPasswordList;
  }

}
