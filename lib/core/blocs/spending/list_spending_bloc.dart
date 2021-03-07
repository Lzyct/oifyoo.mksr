import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/entities/spending_entity.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListSpendingBloc
    extends Cubit<Result<Map<String, Map<String, List<SpendingEntity>>>>> {
  ListSpendingBloc() : super(Result.isLoading());

  SpendingRepository? _spendingRepo = sl<SpendingRepository>();

  listSpending({
    String? searchText,
    SearchType? type,
  }) async {
    emit(Result.isLoading());
    emit(await _spendingRepo!
        .getListSpending(searchText: searchText, type: type));
  }
}
