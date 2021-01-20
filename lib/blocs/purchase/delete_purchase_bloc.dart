import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeletePurchaseBloc extends Cubit<Resources<dynamic>> {
  DeletePurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  deletePurchase(String _transactionNumber) async {
    emit(Resources.loading());
    emit(await _purchaseRepo.deletePurchase(_transactionNumber));
  }
}
