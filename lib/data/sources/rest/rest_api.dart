import 'package:dio/dio.dart';

abstract class RestAPI {
  Future<Response> test({Map<String, String> params});
}
