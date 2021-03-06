import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditPurchaseBloc extends Cubit<Result<dynamic>> {
  EditPurchaseBloc() : super(Result.isLoading());

  var _purchaseRepo = sl<PurchaseRepository>();

  editPurchase(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _purchaseRepo.editPurchase(_params));
  }
}
