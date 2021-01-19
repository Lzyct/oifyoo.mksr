import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class Sale {
  Future<dynamic> addSale(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _note = _params["note"];
    var _buyer = _params["buyer"];
    var _status = _params["status"];
    var _transactionNumber = _params["transactionNumber"];

    List<ProductEntity> _listProduct = _params["listProduct"];

    try {
      for (var item in _listProduct) {
        // insert transaction to db
        var _qty = item.textEditingController.text.toInt();
        await _dbClient.transaction((insert) async => insert.rawInsert('''
           INSERT INTO transaksi(
             transactionNumber,
             idProduct,
             qty,
             productPrice,
             type,
             status,
             note,
             buyer,
             createdAt,
             updatedAt 
           ) VALUES (
             '$_transactionNumber',
             ${item.id},
             $_qty,
             ${item.sellingPrice},
             '${Strings.sale}',
             '$_status',
             '$_note',
             '$_buyer',
             '${DateTime.now()}',
             '${DateTime.now()}'
           )
        '''));

        // Update qty from transaction
        var _query = '''
                  UPDATE product SET 
                      qty = qty-$_qty,
                      updatedAt='${DateTime.now()}'
                  WHERE id=${item.id}
                ''';
        logs("query editSale $_query");
        await _dbClient.transaction((update) async => update.rawUpdate(_query));
      }

      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> editSale(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      var _query = '''
      UPDATE transaksi SET 
          status = ${_params['status']},
          note = ${_params['note']},
          buyer = ${_params['buyer']},
          updatedAt='${DateTime.now()}'
      WHERE transactionNumber=${_params['transactionNumber']}
    ''';
      logs("query editSale $_query");
      await _dbClient.transaction((update) async => update.rawUpdate(_query));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> deleteSale(String _transactionNumber) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      // TODO Revert back qty to product before delete
      await _dbClient.transaction((delete) async => delete.rawDelete('''
        DELETE FROM transaksi WHERE transactionNumber='$_transactionNumber'
      '''));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return e;
    }
  }

  Future<String> transactionNumber() async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      //Format transaction number
      var _query =
          await _dbClient.transaction((delete) async => delete.rawQuery('''
        SELECT COUNT(transactionNumber) FROM transaksi WHERE createdAt like '%${DateTime.now().toString().toDateAlt()}%'
      '''));
      int _count = Sqflite.firstIntValue(_query);
      _count++;
      var _transactionNumber =
          "OIFYOO-MKSR/SL_${DateTime.now().toString().toMonthYear()}_${_count.toString().padLeft(4, "0")}";

      _dbClient.close();
      return _transactionNumber;
    } catch (e) {
      logs(e);
      return e;
    }
  }

  Future<List<TransactionEntity>> getListSale(String searchText) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM transaksi WHERE transactionNumber like '%$searchText%' OR buyer like '%$searchText%' GROUP BY transactionNumber ORDER BY transactionNumber ASC";
    if (searchText.isEmpty) {
      _query = "SELECT * FROM transaksi GROUP BY transactionNumber ORDER BY transactionNumber ASC ";
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<TransactionEntity> _listSale = [];
    _queryMap.forEach((element) {
      _listSale.add(TransactionEntity(
          id: element['id'],
          transactionNumber: element['transactionNumber'],
          idProduct: element['idProduct'],
          qty: element['qty'],
          productPrice: element['productPrice'],
          type: element['type'],
          status: element['status'],
          note: element['note'],
          buyer: element['buyer'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt']));
    });
    _dbClient.close();
    return _listSale;
  }

  Future<List<TransactionEntity>> getDetailSale(
      String _transactionNumber) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM transaksi WHERE transactionNumber='$_transactionNumber'";

    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<TransactionEntity> _listSale = [];
    _queryMap.forEach((element) {
      _listSale.add(TransactionEntity(
          id: element['id'],
          transactionNumber: element['transactionNumber'],
          idProduct: element['idProduct'],
          qty: element['qty'],
          productPrice: element['productPrice'],
          type: element['type'],
          status: element['status'],
          note: element['note'],
          buyer: element['buyer'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt']));
    });
    _dbClient.close();
    return _listSale;
  }
}
