import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditPurchaseBloc extends Cubit<Resources<dynamic>> {
  EditPurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  editPurchase(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _purchaseRepo.editPurchase(_params));
  }
}
