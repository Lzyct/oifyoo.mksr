import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';

abstract class SpendingContract {
  Future<dynamic> addSpending(Map<String, dynamic> _params);

  Future<dynamic> editSpending(Map<String, dynamic> _params);

  Future<dynamic> deleteSpending(int? _id);

  Future<Map<String, Map<String, List<SpendingEntity>>>> getListSpending({
    String? searchText,
    SearchType? type = SearchType.All,
  });

  Future<SpendingEntity> getDetailSpending(int? _id);
}
