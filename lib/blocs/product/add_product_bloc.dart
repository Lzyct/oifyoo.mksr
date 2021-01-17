import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddProductBloc extends Cubit<Resources<dynamic>> {
  AddProductBloc() : super(Resources.loading());

  var _productRepo = sl<ProductRepository>();

  addProduct(Map<String, dynamic> _params) async {
    emit(Resources.loading());
    emit(await _productRepo.addProduct(_params));
  }
}
