import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddSpendingBloc extends Cubit<Resources<dynamic>> {
  AddSpendingBloc() : super(Resources.loading());

  var _spendingRepo = sl<SpendingRepository>();

  addSpending(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _spendingRepo.addSpending(_params));
  }
}
