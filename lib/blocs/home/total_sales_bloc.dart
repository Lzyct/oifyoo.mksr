import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/home_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TotalSalesBloc extends Cubit<Resources<HomeEntity>> {
  TotalSalesBloc() : super(Resources.loading());

  var _homeRepo = sl<HomeRepository>();

  totalSaleAll() async {
    emit(Resources.loading());
    emit(await _homeRepo.totalSalesAll());
  }

  totalSaleCurMonth() async {
    emit(Resources.loading());
    emit(await _homeRepo.totalSalesCurMonth());
  }

  totalSaleLastMonth() async {
    emit(Resources.loading());
    emit(await _homeRepo.totalSalesLastMonth());
  }
}
