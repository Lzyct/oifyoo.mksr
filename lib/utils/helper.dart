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

extension MapWithIndex<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];
    for (int i = 0; i < this.length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}
