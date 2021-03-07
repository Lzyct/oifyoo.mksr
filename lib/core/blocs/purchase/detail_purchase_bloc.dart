import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailPurchaseBloc extends Cubit<Result<List<TransactionEntity>>> {
  DetailPurchaseBloc() : super(Result.isLoading());

  PurchaseRepository? _purchaseRepo = sl<PurchaseRepository>();

  detailPurchase(String _transactionNumber) async {
    emit(Result.isLoading());
    emit(await _purchaseRepo!.getDetailPurchase(_transactionNumber));
  }
}
