import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'utils.dart';

class DioInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    logs(
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    log("Headers:");
    options.headers.forEach((k, v) => log('► $k: $v'));
    if (options.queryParameters != null) {
      log("❖ QueryParameters :");
      try {
        options.queryParameters.forEach((k, v) => log('► $k: $v'));
      } catch (e) {
        log("Error : $e");
      }
    }
    if (options.data != null) {
      try {
        JsonEncoder encoder = new JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(options.data);
        log("Body: $prettyJson");
      } catch (e) {
        log("Error $e");
      }
    }
    return options;
  }

  @override
  Future<dynamic> onError(DioError dioError) async {
    log("<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    log("${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    log("<-- End error");
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    logs(
        "◀ ︎RESPONSE ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    log("Headers:");
    response.headers?.forEach((k, v) => log('$k: $v'));

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyJson = encoder.convert(response.data);
    log("Response: $prettyJson");
    logs("◀ END REQUEST ► ︎");
  }
}
