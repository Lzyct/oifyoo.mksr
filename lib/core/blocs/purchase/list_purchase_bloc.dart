import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListPurchaseBloc extends Cubit<Result<List<TransactionEntity>>> {
  ListPurchaseBloc() : super(Result.isLoading());

  PurchaseRepository? _purchaseRepo = sl<PurchaseRepository>();

  listPurchase(String _searchText) async {
    emit(Result.isLoading());
    emit(await _purchaseRepo!.getListPurchase(_searchText));
  }
}
