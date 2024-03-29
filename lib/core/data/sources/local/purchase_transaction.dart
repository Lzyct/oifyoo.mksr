import 'dart:async';

import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/sources/sources.dart';
import 'package:oifyoo_mksr/core/extensions/extensions.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class PurchaseTransaction extends PurchaseContract {
  @override
  Future<dynamic> addPurchase(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _note = _params["note"];
    var _buyer = _params["buyer"];
    var _status = _params["status"];
    var _transactionNumber = _params["transactionNumber"];
    var _discount = _params['discount'];

    List<ProductEntity> _listProduct = _params["listProduct"];

    try {
      for (var item in _listProduct) {
        // insert transaction to db
        var _qty = item.textEditingController.text.toInt();
        await _dbClient!.transaction((insert) async => insert.rawInsert('''
           INSERT INTO transaksi(
             transactionNumber,
             idProduct,
             qty,
             price,
             discount,
             productName,
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
             ${item.purchasePrice},
             $_discount,
             '${item.productName}',
             '${Strings.purchase}',
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
                      qty = qty+$_qty,
                      updatedAt='${DateTime.now()}'
                  WHERE id=${item.id}
                ''';
        await _dbClient.transaction((update) async => update.rawUpdate(_query));
      }

      _dbClient?.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  @override
  Future<dynamic> editPurchase(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      var _query = '''
      UPDATE transaksi SET 
          status = '${_params['status']}',
          updatedAt='${DateTime.now()}'
      WHERE transactionNumber='${_params['transactionNumber']}'
    ''';
      logs("query $_query");
      await _dbClient!.transaction((update) async => update.rawUpdate(_query));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  @override
  Future<dynamic> deletePurchase(String _transactionNumber) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      // set purchase to void
      var _queryVoid = '''
      UPDATE transaksi SET
          type = '${Strings.purchaseVoid}',
          updatedAt='${DateTime.now()}'
      WHERE transactionNumber='$_transactionNumber'
      ''';
      logs("query void $_queryVoid");
      await _dbClient!
          .transaction((update) async => update.rawUpdate(_queryVoid));

      //return stock to product
      var _queryList = '''
      SELECT * FROM transaksi WHERE transactionNumber = '$_transactionNumber'
      ''';
      List<Map> _queryMap = await _dbClient.rawQuery(_queryList);
      List<TransactionEntity> _listPurchase = [];
      _queryMap.forEach((element) {
        _listPurchase.add(TransactionEntity(
            id: element['id'],
            transactionNumber: element['transactionNumber'],
            idProduct: element['idProduct'],
            qty: element['qty'],
            price: element['price'],
            discount: element['discount'],
            type: element['type'],
            status: element['status'],
            note: element['note'],
            buyer: element['buyer'],
            createdAt: element['createdAt'],
            updatedAt: element['updatedAt'],
            total: element['total']));
      });

      // Loop for update stock
      for (var item in _listPurchase) {
        // restore stock to product
        var _queryReturn = '''
              UPDATE product SET
                  qty = qty-${item.qty},
                  updatedAt='${DateTime.now()}'
              WHERE id='${item.idProduct}'
            ''';
        logs("query void $_queryReturn");
        await _dbClient
            .transaction((update) async => update.rawUpdate(_queryReturn));
      }

      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  @override
  Future<String> transactionNumber() async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      //Format transaction number
      var _query =
          await _dbClient!.transaction((select) async => select.rawQuery('''
        SELECT COUNT(DISTINCT transactionNumber) FROM transaksi 
          WHERE createdAt like '%${DateTime.now().toString().toYearMonth()}%'
          AND transactionNumber like'%PRCHS%'
      '''));

      int _count = Sqflite.firstIntValue(_query)!;
      _count++;
      var _transactionNumber =
          "OIFYOO-MKSR/PRCHS_${DateTime.now().toString().toMonthYear()}_${_count.toString().padLeft(4, "0")}";

      _dbClient.close();
      return _transactionNumber;
    } catch (e) {
      logs(e);
      return e.toString();
    }
  }

  @override
  Future<List<TransactionEntity>> getListPurchase(String searchText) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
    SELECT *,SUM(qty*price) as total FROM transaksi 
      WHERE (transactionNumber like '%$searchText%' OR buyer like '%$searchText%')
      AND type='${Strings.purchase}'
      GROUP BY transactionNumber ORDER BY transactionNumber DESC
    ''';
    if (searchText.isEmpty) {
      _query = '''
      SELECT *,SUM(qty*price) as total FROM transaksi 
        WHERE type='${Strings.purchase}'
        GROUP BY transactionNumber ORDER BY transactionNumber DESC 
      ''';
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient!.rawQuery(_query);
    List<TransactionEntity> _listPurchase = [];
    _queryMap.forEach((element) {
      _listPurchase.add(TransactionEntity(
          id: element['id'],
          transactionNumber: element['transactionNumber'],
          idProduct: element['idProduct'],
          qty: element['qty'],
          price: element['price'],
          type: element['type'],
          status: element['status'],
          note: element['note'],
          buyer: element['buyer'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt'],
          total: element['total']));
    });
    _dbClient.close();
    return _listPurchase;
  }

  @override
  Future<List<TransactionEntity>> getDetailPurchase(
      String _transactionNumber) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM transaksi WHERE transactionNumber='$_transactionNumber'";

    List<Map> _queryMap = await _dbClient!.rawQuery(_query);
    List<TransactionEntity> _listPurchase = [];
    _queryMap.forEach((element) {
      _listPurchase.add(TransactionEntity(
          id: element['id'],
          transactionNumber: element['transactionNumber'],
          idProduct: element['idProduct'],
          qty: element['qty'],
          price: element['price'],
          productName: element['productName'],
          type: element['type'],
          status: element['status'],
          note: element['note'],
          buyer: element['buyer'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt']));
    });
    _dbClient.close();
    return _listPurchase;
  }
}
