import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class PurchaseRepository {
  var _patientDb = sl<Purchase>();

  Future<Resources<String>> transactionNumber() async {
    try {
      var _response = await _patientDb.transactionNumber();
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> addPurchase(Map<String, dynamic> _params) async {
    try {
      var _response = await _patientDb.addPurchase(_params);

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

  Future<Resources<dynamic>> deletePurchase(String _transactionNumber) async {
    try {
      var _response = await _patientDb.deletePurchase(_transactionNumber);
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

  Future<Resources<dynamic>> editPurchase(Map<String, dynamic> _params) async {
    try {
      await _patientDb.editPurchase(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<TransactionEntity>>> getDetailPurchase(
      String _transactionNumber) async {
    try {
      var _response = await _patientDb.getDetailPurchase(_transactionNumber);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<TransactionEntity>>> getListPurchase(
      String _searchText) async {
    try {
      var _response = await _patientDb.getListPurchase(_searchText);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoPurchase);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
