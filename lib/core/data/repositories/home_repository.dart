import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class HomeRepository {
  var _homeTransaction = sl<HomeContract>();

  Future<Result<HomeEntity>> totalSalesAll() async {
    try {
      var _response = await _homeTransaction.totalSalesAll();
      return Result.isSuccess(data: _response, tag: Strings.all);
    } catch (e) {
      logs("error $e");
      return Result.isError(e.toString());
    }
  }

  Future<Result<HomeEntity>> totalSalesCurMonth() async {
    try {
      var _response = await _homeTransaction.totalSalesCurMonth();
      return Result.isSuccess(data: _response, tag: Strings.curMonthTag);
    } catch (e) {
      logs("error $e");
      return Result.isError(e.toString());
    }
  }

  Future<Result<HomeEntity>> totalSalesLastMonth() async {
    try {
      var _response = await _homeTransaction.totalSalesLastMonth();
      return Result.isSuccess(data: _response, tag: Strings.lastMonthTag);
    } catch (e) {
      logs("error $e");
      return Result.isError(e.toString());
    }
  }

  Future<Result<HomeEntity>> totalSpendingAll() async {
    try {
      var _response = await _homeTransaction.totalSpendingAll();
      return Result.isSuccess(data: _response, tag: Strings.all);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<HomeEntity>> totalSpendingCurMonth() async {
    try {
      var _response = await _homeTransaction.totalSpendingCurMonth();
      return Result.isSuccess(data: _response, tag: Strings.curMonthTag);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<HomeEntity>> totalSpendingLastMonth() async {
    try {
      var _response = await _homeTransaction.totalSpendingLastMonth();
      return Result.isSuccess(data: _response, tag: Strings.lastMonthTag);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}
