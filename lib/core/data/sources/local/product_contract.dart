import 'package:oifyoo_mksr/core/data/models/models.dart';

abstract class ProductContract {
  Future<dynamic> addProduct(Map<String, dynamic> _params);

  Future<dynamic> editProduct(Map<String, dynamic> _params);

  Future<dynamic> deleteProduct(int id);

  Future<List<ProductEntity>> getListProduct(String productName);

  Future<ProductEntity> getDetailProduct(int id);
}
