import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/home_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TotalSaleBloc extends Cubit<Resources<HomeEntity>> {
  TotalSaleBloc() : super(Resources.loading());

  var _homeRepo = sl<HomeRepository>();

  totalSale() async {
    emit(Resources.loading());
    emit(await _homeRepo.totalSell());
  }
}
