import 'dart:developer';

import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class HomeTransaction {
  Future<HomeEntity> totalSell() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price*qty) AS total,updatedAt FROM transaksi 
        WHERE type="Penjualan" 
        AND status="Lunas" 
        AND createdAt like '%${DateTime.now().toString().toDateAlt()}%'
        ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }

  Future<HomeEntity> totalPurchase() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price*qty) AS total,updatedAt FROM transaksi 
        WHERE type="Pembelian" 
        AND status="Lunas" 
        AND createdAt like '%${DateTime.now().toString().toDateAlt()}%'
        ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }

  Future<HomeEntity> totalSpending() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price) as total,updatedAt FROM spending WHERE
        createdAt like '%${DateTime.now().toString().toDateAlt()}%'
       ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }
}
