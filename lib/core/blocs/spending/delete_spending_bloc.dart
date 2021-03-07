import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteSpendingBloc extends Cubit<Result<dynamic>> {
  DeleteSpendingBloc() : super(Result.isLoading());

  SpendingRepository? _spendingRepo = sl<SpendingRepository>();

  deleteSpending(int? _id) async {
    emit(Result.isLoading());
    emit(await _spendingRepo!.deleteSpending(_id));
  }
}
