import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class PurchaseRepository {
  PurchaseContract? _purchaseTransaction = sl<PurchaseContract>();

  Future<Result<String>> transactionNumber() async {
    try {
      var _response = await _purchaseTransaction!.transactionNumber();
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> addPurchase(Map<String, dynamic> _params) async {
    try {
      var _response = await _purchaseTransaction!.addPurchase(_params);

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

  Future<Result<dynamic>> deletePurchase(String _transactionNumber) async {
    try {
      var _response =
          await _purchaseTransaction!.deletePurchase(_transactionNumber);
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

  Future<Result<dynamic>> editPurchase(Map<String, dynamic> _params) async {
    try {
      await _purchaseTransaction!.editPurchase(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<TransactionEntity>>> getDetailPurchase(
      String _transactionNumber) async {
    try {
      var _response =
          await _purchaseTransaction!.getDetailPurchase(_transactionNumber);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<TransactionEntity>>> getListPurchase(
      String _searchText) async {
    try {
      var _response = await _purchaseTransaction!.getListPurchase(_searchText);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoPurchase);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}
