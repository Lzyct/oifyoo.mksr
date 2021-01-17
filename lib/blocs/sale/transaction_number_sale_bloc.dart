import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class TransactionNumberSaleBloc extends Cubit<Resources<dynamic>> {
  TransactionNumberSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  transactionNumberSale() async {
    emit(Resources.loading());
    emit(await _saleRepo.transactionNumber());
  }
}
