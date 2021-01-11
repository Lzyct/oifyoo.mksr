import 'dart:convert';
import 'dart:developer';

logs(dynamic message) {
  log("========================================================================================");
  log("| Message Log : $message");
  log("========================================================================================");
}

logsJson(dynamic message) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyJson = encoder.convert(message);
  log("========================================================================================");
  log("| Message Log : $prettyJson");
  log("========================================================================================");
}
