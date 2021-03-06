import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TransactionNumberSaleBloc extends Cubit<Result<dynamic>> {
  TransactionNumberSaleBloc() : super(Result.isLoading());

  var _saleRepo = sl<SaleRepository>();

  transactionNumberSale() async {
    emit(Result.isLoading());
    emit(await _saleRepo.transactionNumber());
  }
}
