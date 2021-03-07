import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListSaleBloc
    extends Cubit<Result<Map<String, Map<String, List<TransactionEntity>>>>> {
  ListSaleBloc() : super(Result.isLoading());

  SaleRepository? _saleRepo = sl<SaleRepository>();

  listSale({
    String? searchText,
    SearchType? type,
  }) async {
    emit(Result.isLoading());
    emit(await _saleRepo!.getListSale(searchText: searchText, type: type));
  }
}
