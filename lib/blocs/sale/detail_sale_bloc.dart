import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailSaleBloc extends Cubit<Resources<List<TransactionEntity>>> {
  DetailSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  detailSale(String _transactionNumber) async {
    emit(Resources.loading());
    emit(await _saleRepo.getDetailSale(_transactionNumber));
  }
}
