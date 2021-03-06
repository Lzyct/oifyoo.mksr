import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';

abstract class SaleContract {
  Future<dynamic> addSale(Map<String, dynamic> _params);

  Future<dynamic> editSale(Map<String, dynamic> _params);

  Future<dynamic> deleteSale(String _transactionNumber);

  Future<String> transactionNumber();

  Future<Map<String, Map<String, List<TransactionEntity>>>> getListSale({
    String searchText,
    SearchType type = SearchType.All,
  });

  Future<List<TransactionEntity>> getDetailSale(String _transactionNumber);
}
