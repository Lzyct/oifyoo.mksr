import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListSaleBloc extends Cubit<Resources<List<TransactionEntity>>> {
  ListSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  listSale(String _searchText) async {
    emit(Resources.loading());
    emit(await _saleRepo.getListSale(_searchText));
  }
}
