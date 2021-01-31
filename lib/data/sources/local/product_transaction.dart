import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class ProductTransaction {
  Future<dynamic> addProduct(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await _dbClient.transaction((insert) async => insert.rawInsert('''
      INSERT INTO product(
        productName,
        note,
        qty,
        sellingPrice,
        purchasePrice,
        createdAt,
        updatedAt
      ) VALUES (
        '${_params['productName']}',
        '${_params['note']}',
        '${_params['qty']}',
        '${_params['sellingPrice']}',
        0,
        '${DateTime.now()}',
        '${DateTime.now()}'
      )
    '''));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.errorProductExist;
    }
  }

  Future<dynamic> editProduct(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      var _query = '''
      UPDATE product SET 
          productName = '${_params['productName']}',
          note = '${_params['note']}',
          sellingPrice = ${_params['sellingPrice']},
          qty= ${_params['qty']},
          updatedAt='${DateTime.now()}'
      WHERE id=${_params['id']}
    ''';
      logs("query editProduct $_query");
      await _dbClient.transaction((update) async => update.rawUpdate(_query));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> deleteProduct(int id) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await _dbClient.transaction((delete) async => delete.rawDelete('''
        DELETE FROM product WHERE id='$id'
      '''));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return e;
    }
  }

  Future<List<ProductEntity>> getListProduct(String productName) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM product WHERE productName like '%$productName%' ORDER BY productName ASC";
    if (productName.isEmpty) {
      _query = "SELECT * FROM product ORDER BY productName ASC";
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<ProductEntity> _listProduct = [];
    _queryMap.forEach((element) {
      _listProduct.add(ProductEntity(
          id: element["id"],
          productName: element["productName"],
          note: element["note"],
          qty: element["qty"],
          sellingPrice: element["sellingPrice"],
          purchasePrice: element["purchasePrice"],
          createdAt: element["createdAt"],
          updatedAt: element["updatedAt"]));
    });
    _dbClient.close();
    return _listProduct;
  }

  Future<ProductEntity> getDetailProduct(int id) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = "SELECT * FROM product WHERE id='$id'";

    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<ProductEntity> _listProduct = [];
    _queryMap.forEach((element) {
      _listProduct.add(ProductEntity(
          id: element["id"],
          productName: element["productName"],
          note: element["note"],
          qty: element["qty"],
          sellingPrice: element["sellingPrice"],
          purchasePrice: element["purchasePrice"],
          createdAt: element["createdAt"],
          updatedAt: element["updatedAt"]));
    });
    _dbClient.close();
    return _listProduct[0];
  }
}
