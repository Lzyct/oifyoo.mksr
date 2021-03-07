import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailSpendingBloc extends Cubit<Result<SpendingEntity>> {
  DetailSpendingBloc() : super(Result.isLoading());

  SpendingRepository? _spendingRepo = sl<SpendingRepository>();

  detailSpending(int? _id) async {
    emit(Result.isLoading());
    emit(await _spendingRepo!.getDetailSpending(_id));
  }
}
