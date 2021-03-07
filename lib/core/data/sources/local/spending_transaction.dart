import 'dart:async';

import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class SpendingTransaction extends SpendingContract {
  @override
  Future<dynamic> addSpending(Map<String, dynamic> _params) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await _dbClient!.transaction((insert) async => insert.rawInsert('''
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

  @override
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
      await _dbClient!.transaction((update) async => update.rawUpdate(_query));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  @override
  Future<dynamic> deleteSpending(int? _id) async {
    var _dbClient = await sl.get<DbHelper>().dataBase;
    try {
      // set purchase to void
      var _queryVoid = '''
        DELETE FROM spending
          WHERE id='$_id'
      ''';
      await _dbClient!
          .transaction((delete) async => delete.rawDelete(_queryVoid));
      _dbClient.close();
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  @override
  Future<Map<String, Map<String, List<SpendingEntity>>>> getListSpending({
    String? searchText,
    SearchType? type = SearchType.All,
  }) async {
    //connect db
    logs("SearchType $type");
    var _mapListSpending = Map<String, Map<String, List<SpendingEntity>>>();

    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = "";
    try {
      switch (type) {
        case SearchType.All:
          {
            _query = '''
                SELECT * FROM spending 
                  WHERE (name like '%$searchText%' OR note like '%$searchText%')
                  ORDER BY id DESC
                ''';
            if (searchText!.isEmpty) {
              _query = '''
                   SELECT * FROM spending ORDER BY id DESC 
                  ''';
            }
          }
          break;
        case SearchType.Month:
          {
            _query = '''
                SELECT * FROM spending 
                  WHERE (name like '%$searchText%' OR note like '%$searchText%')
                  AND createdAt like '%${DateTime.now().toString().toYearMonth()}%'
                  ORDER BY id DESC
                ''';
            if (searchText!.isEmpty) {
              _query = '''
                   SELECT * FROM spending
                   WHERE createdAt like '%${DateTime.now().toString().toYearMonth()}%'
                   ORDER BY id DESC 
                  ''';
            }
          }
          break;
        case SearchType.Day:
          {
            _query = '''
                SELECT * FROM spending 
                  WHERE (name like '%$searchText%' OR note like '%$searchText%')
                  AND createdAt like '%${DateTime.now().toString().toDate()}%'
                  ORDER BY id DESC
                ''';
            if (searchText!.isEmpty) {
              _query = '''
                   SELECT * FROM spending 
                   WHERE createdAt like '%${DateTime.now().toString().toDate()}%'
                   ORDER BY id DESC 
                  ''';
            }
          }
          break;
        default:
      }

      logs("Query -> $_query");
      List<Map> _queryMap = await _dbClient!.rawQuery(_query);
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

      // distinct date to group
      var _distinctDate =
          _listSpending.map((e) => e.createdAt!.toDate()).toSet();
      // loop to show all distinct date
      // then add to map using date as key
      // for second map using total for that day as key
      // and add list transaction by date
      _distinctDate.forEach((element) {
        logs("print date $element");
        // filter transaction by date
        String _date = element;
        int _total = 0;
        List<SpendingEntity> _listSpendingOfDate = [];
        var _mapTotal = Map<String, List<SpendingEntity>>();
        _listSpendingOfDate = _listSpending
            .where((element) => element.createdAt!.toDate() == _date)
            .toList();
        _listSpendingOfDate.forEach((elementSpendingOfDate) {
          logs("qty ${elementSpendingOfDate.name}");
          logs("price ${elementSpendingOfDate.price}");
          _total += elementSpendingOfDate.price!;
          logs("Total of transaction id ${elementSpendingOfDate.id} $_total");
        });
        _mapTotal["$_total"] = _listSpendingOfDate;
        _mapListSpending["$element"] = _mapTotal;

        logs("mapListSpending for date $element -> $_mapListSpending");
      });
    } catch (e) {
      logs("error $e");
    }
    _dbClient!.close();
    return _mapListSpending;
  }

  @override
  Future<SpendingEntity> getDetailSpending(int? _id) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query = "SELECT * FROM spending WHERE id='$_id'";

    List<Map> _queryMap = await _dbClient!.rawQuery(_query);
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
