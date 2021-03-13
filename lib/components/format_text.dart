import 'package:flutter/services.dart';

class UpperCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldTxt, TextEditingValue newTxt) {
    return newTxt.copyWith(text: newTxt.text.toUpperCase());
  }
}
