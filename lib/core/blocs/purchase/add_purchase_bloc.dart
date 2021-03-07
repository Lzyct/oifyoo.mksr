import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddPurchaseBloc extends Cubit<Result<dynamic>> {
  AddPurchaseBloc() : super(Result.isLoading());

  PurchaseRepository? _purchaseRepo = sl<PurchaseRepository>();

  addPurchase(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _purchaseRepo!.addPurchase(_params));
  }
}
