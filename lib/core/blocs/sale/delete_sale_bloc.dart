import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteSaleBloc extends Cubit<Result<dynamic>> {
  DeleteSaleBloc() : super(Result.isLoading());

  SaleRepository? _saleRepo = sl<SaleRepository>();

  deleteSale(String? _transactionNumber) async {
    emit(Result.isLoading());
    emit(await _saleRepo!.deleteSale(_transactionNumber));
  }
}
