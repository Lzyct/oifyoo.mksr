import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteSaleBloc extends Cubit<Resources<dynamic>> {
  DeleteSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  deleteSale(String _transactionNumber) async {
    emit(Resources.loading());
    emit(await _saleRepo.deleteSale(_transactionNumber));
  }
}
