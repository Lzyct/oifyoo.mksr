import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';

class ListSaleBloc extends Cubit<Resources<List<TransactionEntity>>> {
  ListSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  listSale({
    String searchText,
    SearchType type,
  }) async {
    emit(Resources.loading());
    emit(await _saleRepo.getListSale(searchText: searchText, type: type));
  }
}
