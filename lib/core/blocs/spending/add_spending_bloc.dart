import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddSpendingBloc extends Cubit<Result<dynamic>> {
  AddSpendingBloc() : super(Result.isLoading());

  var _spendingRepo = sl<SpendingRepository>();

  addSpending(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _spendingRepo.addSpending(_params));
  }
}
