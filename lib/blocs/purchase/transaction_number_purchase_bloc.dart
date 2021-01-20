import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TransactionNumberPurchaseBloc extends Cubit<Resources<dynamic>> {
  TransactionNumberPurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  transactionNumberPurchase() async {
    emit(Resources.loading());
    emit(await _purchaseRepo.transactionNumber());
  }
}
