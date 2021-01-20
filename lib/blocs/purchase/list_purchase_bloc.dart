import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListPurchaseBloc extends Cubit<Resources<List<TransactionEntity>>> {
  ListPurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  listPurchase(String _searchText) async {
    emit(Resources.loading());
    emit(await _purchaseRepo.getListPurchase(_searchText));
  }
}
