import 'package:oifyoo_mksr/data/models/responses/diagnostic.dart';

class DiagnosticResponse {
  Diagnostic diagnostic;

  DiagnosticResponse({this.diagnostic});

  DiagnosticResponse.fromJson(Map<String, dynamic> json) {
    diagnostic = json['diagnostic'] != null
        ? new Diagnostic.fromJson(json['diagnostic'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diagnostic != null) {
      data['diagnostic'] = this.diagnostic.toJson();
    }
    return data;
  }
}
