import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TransactionNumberPurchaseBloc extends Cubit<Result<dynamic>> {
  TransactionNumberPurchaseBloc() : super(Result.isLoading());

  var _purchaseRepo = sl<PurchaseRepository>();

  transactionNumberPurchase() async {
    emit(Result.isLoading());
    emit(await _purchaseRepo.transactionNumber());
  }
}
