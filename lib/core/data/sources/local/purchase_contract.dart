import 'package:oifyoo_mksr/core/data/models/models.dart';

abstract class PurchaseContract {
  Future<dynamic> addPurchase(Map<String, dynamic> _params);

  Future<dynamic> editPurchase(Map<String, dynamic> _params);

  Future<dynamic> deletePurchase(String _transactionNumber);

  Future<String> transactionNumber();

  Future<List<TransactionEntity>> getListPurchase(String searchText);

  Future<List<TransactionEntity>> getDetailPurchase(String _transactionNumber);
}
