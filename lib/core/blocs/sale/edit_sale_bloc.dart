import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditSaleBloc extends Cubit<Result<dynamic>> {
  EditSaleBloc() : super(Result.isLoading());

  var _saleRepo = sl<SaleRepository>();

  editSale(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _saleRepo.editSale(_params));
  }
}
