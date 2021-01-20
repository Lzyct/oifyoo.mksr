import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddPurchaseBloc extends Cubit<Resources<dynamic>> {
  AddPurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  addPurchase(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _purchaseRepo.addPurchase(_params));
  }
}
