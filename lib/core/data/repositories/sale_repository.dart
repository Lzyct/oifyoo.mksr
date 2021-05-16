import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/core/enums/payment_state.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SaleRepository {
  SaleContract _saleTransaction = sl<SaleContract>();

  Future<Result<String>> transactionNumber() async {
    try {
      var _response = await _saleTransaction.transactionNumber();
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> addSale(Map<String, dynamic> _params) async {
    try {
      var _response = await _saleTransaction.addSale(_params);

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

  Future<Result<dynamic>> deleteSale(String? _transactionNumber) async {
    try {
      var _response = await _saleTransaction.deleteSale(_transactionNumber);
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

  Future<Result<dynamic>> editSale(Map<String, dynamic> _params) async {
    try {
      await _saleTransaction.editSale(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<TransactionEntity>>> getDetailSale(
      String? _transactionNumber) async {
    try {
      var _response = await _saleTransaction.getDetailSale(_transactionNumber);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<Map<String, Map<String, List<TransactionEntity>>>>>
      getListSale({
    String? searchText,
    required SearchType type,
    required PaymentState paymentState,
  }) async {
    try {
      var _response = await _saleTransaction.getListSale(
          searchText: searchText, type: type, paymentState: paymentState);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoSale);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}
