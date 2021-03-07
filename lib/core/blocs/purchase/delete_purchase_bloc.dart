import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeletePurchaseBloc extends Cubit<Result<dynamic>> {
  DeletePurchaseBloc() : super(Result.isLoading());

  PurchaseRepository? _purchaseRepo = sl<PurchaseRepository>();

  deletePurchase(String _transactionNumber) async {
    emit(Result.isLoading());
    emit(await _purchaseRepo!.deletePurchase(_transactionNumber));
  }
}
