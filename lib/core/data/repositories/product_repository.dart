import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class ProductRepository {
  ProductContract? _productTransaction = sl<ProductContract>();

  Future<Result<dynamic>> addProduct(Map<String, dynamic> _params) async {
    try {
      var _response = await _productTransaction!.addProduct(_params);

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

  Future<Result<dynamic>> deleteProduct(int? _id) async {
    try {
      var _response = await _productTransaction!.deleteProduct(_id);
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

  Future<Result<dynamic>> editProduct(Map<String, dynamic> _params) async {
    try {
      await _productTransaction!.editProduct(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<ProductEntity>> getDetailProduct(int? _id) async {
    try {
      var _response = await _productTransaction!.getDetailProduct(_id);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<ProductEntity>>> getListProduct(String productName) async {
    try {
      var _response = await _productTransaction!.getListProduct(productName);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoProduct);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}
