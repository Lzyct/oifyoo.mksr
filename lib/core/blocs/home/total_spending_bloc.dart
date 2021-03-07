import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/entities/home_entity.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TotalSpendingBloc extends Cubit<Result<HomeEntity>> {
  TotalSpendingBloc() : super(Result.isLoading());

  HomeRepository? _homeRepo = sl<HomeRepository>();

  totalSpendingAll() async {
    emit(Result.isLoading());
    emit(await _homeRepo!.totalSpendingAll());
  }

  totalSpendingCurMonth() async {
    emit(Result.isLoading());
    emit(await _homeRepo!.totalSpendingCurMonth());
  }

  totalSpendingLastMonth() async {
    emit(Result.isLoading());
    emit(await _homeRepo!.totalSpendingLastMonth());
  }
}
