import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/spending_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailSpendingBloc extends Cubit<Resources<SpendingEntity>> {
  DetailSpendingBloc() : super(Resources.loading());

  var _spendingRepo = sl<SpendingRepository>();

  detailSpending(int _id) async {
    emit(Resources.loading());
    emit(await _spendingRepo.getDetailSpending(_id));
  }
}
