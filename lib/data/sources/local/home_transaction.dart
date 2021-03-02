import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class HomeTransaction {
  // Total Sales Section
  Future<HomeEntity> totalSalesAll() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price*qty) AS total,SUM(distinct discount) as sumDiscount,updatedAt FROM transaksi 
        WHERE type="Penjualan" 
        AND status="Lunas" 
        ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    int _sumTotal = _queryMap[0]["total"] ?? 0;
    int _sumDiscount = _queryMap[0]["sumDiscount"] ?? 0;

    logs("total ${_queryMap[0]["total"]}");
    logs("sumDiscount ${_queryMap[0]["sumDiscount"]}");

    _dbClient.close();
    var _home = HomeEntity(
        total: _sumTotal - _sumDiscount, updatedAt: _queryMap[0]["updatedAt"]);
    logs("home $_home");
    return _home;
  }

  Future<HomeEntity> totalSalesCurMonth() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price*qty) AS total,SUM(distinct discount) as sumDiscount,updatedAt FROM transaksi 
        WHERE type="Penjualan" 
        AND status="Lunas" 
        AND createdAt like '%${DateTime.now().toString().toYearMonth()}%'
        ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    int _sumTotal = _queryMap[0]["total"] ?? 0;
    int _sumDiscount = _queryMap[0]["sumDiscount"] ?? 0;

    logs("total ${_queryMap[0]["total"]}");
    logs("sumDiscount ${_queryMap[0]["sumDiscount"]}");

    _dbClient.close();
    var _home = HomeEntity(
        total: _sumTotal - _sumDiscount, updatedAt: _queryMap[0]["updatedAt"]);
    logs("home $_home");
    return _home;
  }

  Future<HomeEntity> totalSalesLastMonth() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price*qty) AS total,SUM(distinct discount) as sumDiscount,updatedAt FROM transaksi 
        WHERE type="Penjualan" 
        AND status="Lunas" 
        AND createdAt like '%${DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day).toString().toYearMonth()}%'
        ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    int _sumTotal = _queryMap[0]["total"] ?? 0;
    int _sumDiscount = _queryMap[0]["sumDiscount"] ?? 0;

    logs("total ${_queryMap[0]["total"]}");
    logs("sumDiscount ${_queryMap[0]["sumDiscount"]}");

    _dbClient.close();
    var _home = HomeEntity(
        total: _sumTotal - _sumDiscount, updatedAt: _queryMap[0]["updatedAt"]);
    logs("home $_home");
    return _home;
  }

  // Total Spending Section

  Future<HomeEntity> totalSpendingAll() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price) as total,updatedAt FROM spending 
       ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }

  Future<HomeEntity> totalSpendingCurMonth() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price) as total,updatedAt FROM spending WHERE
        createdAt like '%${DateTime.now().toString().toYearMonth()}%'
       ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }

  Future<HomeEntity> totalSpendingLastMonth() async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
      SELECT SUM(price) as total,updatedAt FROM spending WHERE
        createdAt like '%${DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day).toString().toYearMonth()}%'
       ORDER BY updatedAt DESC
    ''';

    List<Map> _queryMap = await _dbClient.rawQuery(_query);

    _dbClient.close();
    var _home = HomeEntity(
        total: _queryMap[0]["total"], updatedAt: _queryMap[0]["updatedAt"]);
    return _home;
  }
}
