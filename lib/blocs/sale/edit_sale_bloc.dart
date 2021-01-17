import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditSaleBloc extends Cubit<Resources<dynamic>> {
  EditSaleBloc() : super(Resources.loading());

  var _saleRepo = sl<SaleRepository>();

  editSale(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _saleRepo.editSale(_params));
  }
}
