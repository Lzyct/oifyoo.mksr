import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class ProductRepository {
  var _patientDb = sl<Product>();

  Future<Resources<dynamic>> addProduct(Map<String, dynamic> _params) async {
    try {
      var _response = await _patientDb.addProduct(_params);

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

  Future<Resources<dynamic>> deleteProduct(int _id) async {
    try {
      var _response = await _patientDb.deleteProduct(_id);
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

  Future<Resources<dynamic>> editProduct(Map<String, dynamic> _params) async {
    try {
      await _patientDb.editProduct(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<ProductEntity>> getDetailProduct(int _id) async {
    try {
      var _response = await _patientDb.getDetailProduct(_id);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<ProductEntity>>> getListProduct(String productName) async {
    try {
      var _response = await _patientDb.getListProduct(productName);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoProduct);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}
