import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailSaleBloc extends Cubit<Result<List<TransactionEntity>>> {
  DetailSaleBloc() : super(Result.isLoading());

  var _saleRepo = sl<SaleRepository>();

  detailSale(String _transactionNumber) async {
    emit(Result.isLoading());
    emit(await _saleRepo.getDetailSale(_transactionNumber));
  }
}
