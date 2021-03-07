import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditSpendingBloc extends Cubit<Result<dynamic>> {
  EditSpendingBloc() : super(Result.isLoading());

  SpendingRepository? _spendingRepo = sl<SpendingRepository>();

  editSpending(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _spendingRepo!.editSpending(_params));
  }
}
