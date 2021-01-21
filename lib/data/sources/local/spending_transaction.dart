import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SpendingTransaction {
  Future<dynamic> addSpending(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await _dbClient.transaction((insert) async => insert.rawInsert('''
           INSERT INTO spending(
             name,
             price,
             note,
             createdAt,
             updatedAt 
           ) VALUES (
             '${_params['name']}',
             ${_params['price']},
             '${_params['note']}', 
             '${DateTime.now()}',
             '${DateTime.now()}'
           )
        '''));

      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> editSpending(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      var _query = '''
      UPDATE spending SET 
          name = '${_params['name']}',
          price = ${_params['price']},
          note = '${_params['note']}',
          updatedAt='${DateTime.now()}'
      WHERE id='${_params['id']}'
    ''';
      logs("query $_query");
      await _dbClient.transaction((update) async => update.rawUpdate(_query));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> deleteSpending(int _id) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      // set purchase to void
      var _queryVoid = '''
        DELETE FROM spending
          WHERE id='$_id'
      ''';
      await _dbClient
          .transaction((delete) async => delete.rawDelete(_queryVoid));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<List<SpendingEntity>> getListSpending(String searchText) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = '''
    SELECT * FROM spending 
      WHERE (name like '%$searchText%' OR note like '%$searchText%')
      ORDER BY id DESC
    ''';
    if (searchText.isEmpty) {
      _query = '''
       SELECT * FROM spending ORDER BY id DESC 
      ''';
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<SpendingEntity> _listSpending = [];
    _queryMap.forEach((element) {
      _listSpending.add(SpendingEntity(
          id: element['id'],
          name: element['name'],
          note: element['note'],
          price: element['price'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt']));
    });
    _dbClient.close();
    return _listSpending;
  }

  Future<SpendingEntity> getDetailSpending(int _id) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = "SELECT * FROM spending WHERE id='$_id'";

    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<SpendingEntity> _listSpending = [];
    _queryMap.forEach((element) {
      _listSpending.add(SpendingEntity(
          id: element['id'],
          name: element['name'],
          note: element['note'],
          price: element['price'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt']));
    });
    _dbClient.close();
    return _listSpending[0];
  }
}
