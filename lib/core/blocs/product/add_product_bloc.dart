import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class AddProductBloc extends Cubit<Result<dynamic>> {
  AddProductBloc() : super(Result.isLoading());

  ProductRepository? _productRepo = sl<ProductRepository>();

  addProduct(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _productRepo!.addProduct(_params));
  }
}
