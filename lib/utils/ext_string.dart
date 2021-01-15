import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';
import 'package:oktoast/oktoast.dart';

extension StringExtension on String {
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  String toDate() {
    var object = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
    return DateFormat("dd MMMM yyyy").format(object);
  }

  String toClock() {
    var object = new DateFormat("HH:mm:ss").parse(this);
    return DateFormat("HH:mm").format(object);
  }

  toToastError() {
    try {
      var message = this == null || this.isEmpty ? "error" : this;

      showToastWidget(
          Toast(
            bgColor: Palette.red,
            icon: Icons.error,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 2));
    } catch (e) {
      print("error $e");
    }
  }

  toToastSuccess() {
    try {
      var message = (this == null || this.isEmpty) ? "success" : this;

      // showToast(msg)
      showToastWidget(
          Toast(
            bgColor: Colors.green,
            icon: Icons.check_circle,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 2));
    } catch (e) {
      print("success $e");
    }
  }

  toToastLoading() {
    try {
      var message = this == null || this.isEmpty ? "loading" : this;
      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
          Toast(
            bgColor: Colors.black,
            icon: Icons.info,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 3));
    } catch (e) {
      print("loading $e");
    }
  }

  String toCurrency() {
    if (this.isNotEmpty) {
      //clean string before format
      var value = this.replaceAll(".", "");
      return NumberFormat.currency(
        symbol: "",
        decimalDigits: 0,
      ).format(int.parse(value)).replaceAll(",", ".");
    }
    return "0";
  }

  String toClearText() {
    return this.replaceAll(".", "");
  }

  String toIDR() {
    if (this.isNotEmpty) {
      //clean string before format
      var value = this.replaceAll(".", "");
      return NumberFormat.currency(
        symbol: "Rp. ",
        decimalDigits: 0,
      ).format(int.parse(value)).replaceAll(",", ".");
    }
    return "0";
  }
}
