import 'package:oifyoo_mksr/di/di.dart';
import 'package:dio/dio.dart';

import '../sources.dart';

class RestApiImpl with RestAPI {
  var _dio = sl<API>().getDio();

  @override
  Future<Response> test({Map<String, String> params}) async =>
      await _dio.post("/api/token", data: params);
}
