import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class HomeRepository {
  var _homeTransaction = sl<HomeTransaction>();

  Future<Resources<HomeEntity>> totalSell() async {
    try {
      var _response = await _homeTransaction.totalSell();
      return Resources.success(data: _response);
    } catch (e) {
      logs("error $e");
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalPurchase() async {
    try {
      var _response = await _homeTransaction.totalPurchase();
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSpending() async {
    try {
      var _response = await _homeTransaction.totalSpending();
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
