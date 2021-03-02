import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class HomeRepository {
  var _homeTransaction = sl<HomeTransaction>();

  Future<Resources<HomeEntity>> totalSalesAll() async {
    try {
      var _response = await _homeTransaction.totalSalesAll();
      return Resources.success(data: _response, tag: Strings.all);
    } catch (e) {
      logs("error $e");
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSalesCurMonth() async {
    try {
      var _response = await _homeTransaction.totalSalesCurMonth();
      return Resources.success(data: _response, tag: Strings.curMonthTag);
    } catch (e) {
      logs("error $e");
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSalesLastMonth() async {
    try {
      var _response = await _homeTransaction.totalSalesLastMonth();
      return Resources.success(data: _response, tag: Strings.lastMonthTag);
    } catch (e) {
      logs("error $e");
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSpendingAll() async {
    try {
      var _response = await _homeTransaction.totalSpendingAll();
      return Resources.success(data: _response, tag: Strings.all);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSpendingCurMonth() async {
    try {
      var _response = await _homeTransaction.totalSpendingCurMonth();
      return Resources.success(data: _response, tag: Strings.curMonthTag);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<HomeEntity>> totalSpendingLastMonth() async {
    try {
      var _response = await _homeTransaction.totalSpendingLastMonth();
      return Resources.success(data: _response, tag: Strings.lastMonthTag);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
