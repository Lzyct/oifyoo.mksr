import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddSaleBloc extends Cubit<Result<dynamic>> {
  AddSaleBloc() : super(Result.isLoading());

  SaleRepository? _saleRepo = sl<SaleRepository>();

  addSale(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _saleRepo!.addSale(_params));
  }
}
