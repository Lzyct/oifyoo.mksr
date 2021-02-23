import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SaleRepository {
  var _saleTransaction = sl<SaleTransaction>();

  Future<Resources<String>> transactionNumber() async {
    try {
      var _response = await _saleTransaction.transactionNumber();
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> addSale(Map<String, dynamic> _params) async {
    try {
      var _response = await _saleTransaction.addSale(_params);

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

  Future<Resources<dynamic>> deleteSale(String _transactionNumber) async {
    try {
      var _response = await _saleTransaction.deleteSale(_transactionNumber);
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

  Future<Resources<dynamic>> editSale(Map<String, dynamic> _params) async {
    try {
      await _saleTransaction.editSale(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<TransactionEntity>>> getDetailSale(
      String _transactionNumber) async {
    try {
      var _response = await _saleTransaction.getDetailSale(_transactionNumber);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<TransactionEntity>>> getListSale({
    String searchText,
    SearchType type,
  }) async {
    try {
      var _response = await _saleTransaction.getListSale(
          searchText: searchText, type: type);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoSale);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
