import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SpendingRepository {
  var _spendingTransaction = sl<SpendingTransaction>();

  Future<Resources<dynamic>> addSpending(Map<String, dynamic> _params) async {
    try {
      var _response = await _spendingTransaction.addSpending(_params);

      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Resources.success(data: true);
      } else {
        return Resources.error(_response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> deleteSpending(int _id) async {
    try {
      var _response = await _spendingTransaction.deleteSpending(_id);
      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Resources.success(data: true);
      } else {
        return Resources.error(_response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> editSpending(Map<String, dynamic> _params) async {
    try {
      await _spendingTransaction.editSpending(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<SpendingEntity>> getDetailSpending(int _id) async {
    try {
      var _response = await _spendingTransaction.getDetailSpending(_id);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<Map<String, Map<String, List<SpendingEntity>>>>>
      getListSpending({
    String searchText,
    SearchType type,
  }) async {
    try {
      var _response = await _spendingTransaction.getListSpending(
          searchText: searchText, type: type);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoSpending);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
