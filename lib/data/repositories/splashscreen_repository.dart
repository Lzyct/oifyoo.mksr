import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';

class SplashScreenRepository {
  Future<Resources<String>> dictionary() async {
    var _restApi = sl<RestApiImpl>();
    try {
      var _responseTest = await _restApi.test();

      if (_responseTest.statusCode == 200) {
        return Resources.success(data: "Success");
      } else {
        return Resources.error("Error Message");
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
