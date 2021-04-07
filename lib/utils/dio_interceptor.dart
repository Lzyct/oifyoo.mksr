import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'utils.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logs(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
    log("Headers:");
    options.headers.forEach((k, v) => log('► $k: $v'));
    log("❖ QueryParameters :");
    try {
      options.queryParameters.forEach((k, v) => log('► $k: $v'));
    } catch (e) {
      log("Error : $e");
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

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    log("<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    log("${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
    log("<-- End error");
    super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logs(
        // ignore: unnecessary_null_comparison
        "◀ ︎RESPONSE ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    log("Headers:");
    response.headers.forEach((k, v) => log('$k: $v'));

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyJson = encoder.convert(response.data);
    log("Response: $prettyJson");
    logs("◀ END REQUEST ► ︎");
    super.onResponse(response, handler);
  }
/*
  @override
  Future<dynamic> onResponse(Response response) async {

  }*/
}
