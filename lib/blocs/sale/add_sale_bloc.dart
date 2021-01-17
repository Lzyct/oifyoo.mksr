import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddSaleBloc extends Cubit<Resources<dynamic>> {
  AddSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  addSale(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _saleRepo.addSale(_params));
  }
}
