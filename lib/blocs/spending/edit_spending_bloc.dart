import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditSpendingBloc extends Cubit<Resources<dynamic>> {
  EditSpendingBloc() : super(Resources.loading());

  var _spendingRepo = sl<SpendingRepository>();

  editSpending(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _spendingRepo.editSpending(_params));
  }
}
