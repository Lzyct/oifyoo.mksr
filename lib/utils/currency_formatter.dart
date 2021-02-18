import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  CurrencyFormatter({this.maxDigits});

  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    String newText =
        NumberFormat.currency(symbol: "", decimalDigits: 0, locale: 'id')
            .format(value);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
