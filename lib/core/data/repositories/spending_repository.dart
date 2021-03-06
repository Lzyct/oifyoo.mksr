import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SpendingRepository {
  var _spendingTransaction = sl<SpendingContract>();

  Future<Result<dynamic>> addSpending(Map<String, dynamic> _params) async {
    try {
      var _response = await _spendingTransaction.addSpending(_params);

      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Result.isSuccess(data: true);
      } else {
        return Result.isError(_response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> deleteSpending(int _id) async {
    try {
      var _response = await _spendingTransaction.deleteSpending(_id);
      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Result.isSuccess(data: true);
      } else {
        return Result.isError(_response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> editSpending(Map<String, dynamic> _params) async {
    try {
      await _spendingTransaction.editSpending(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<SpendingEntity>> getDetailSpending(int _id) async {
    try {
      var _response = await _spendingTransaction.getDetailSpending(_id);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<Map<String, Map<String, List<SpendingEntity>>>>>
      getListSpending({
    String searchText,
    SearchType type,
  }) async {
    try {
      var _response = await _spendingTransaction.getListSpending(
          searchText: searchText, type: type);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoSpending);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}
