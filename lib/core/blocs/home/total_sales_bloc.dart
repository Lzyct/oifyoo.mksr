import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/entities/home_entity.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TotalSalesBloc extends Cubit<Result<HomeEntity>> {
  TotalSalesBloc() : super(Result.isLoading());

  var _homeRepo = sl<HomeRepository>();

  totalSaleAll() async {
    emit(Result.isLoading());
    emit(await _homeRepo.totalSalesAll());
  }

  totalSaleCurMonth() async {
    emit(Result.isLoading());
    emit(await _homeRepo.totalSalesCurMonth());
  }

  totalSaleLastMonth() async {
    emit(Result.isLoading());
    emit(await _homeRepo.totalSalesLastMonth());
  }
}
