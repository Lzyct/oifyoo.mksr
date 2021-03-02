import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/spending_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';

class ListSpendingBloc
    extends Cubit<Resources<Map<String, Map<String, List<SpendingEntity>>>>> {
  ListSpendingBloc() : super(Resources.loading());

  var _spendingRepo = sl<SpendingRepository>();

  listSpending({
    String searchText,
    SearchType type,
  }) async {
    emit(Resources.loading());
    emit(await _spendingRepo.getListSpending(
        searchText: searchText, type: type));
  }
}
