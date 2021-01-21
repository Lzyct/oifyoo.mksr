import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteSpendingBloc extends Cubit<Resources<dynamic>> {
  DeleteSpendingBloc() : super(Resources.loading());

  var _spendingRepo = sl<SpendingRepository>();

  deleteSpending(int _id) async {
    emit(Resources.loading());
    emit(await _spendingRepo.deleteSpending(_id));
  }
}
