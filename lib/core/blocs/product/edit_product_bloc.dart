import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class EditProductBloc extends Cubit<Result<dynamic>> {
  EditProductBloc() : super(Result.isLoading());

  ProductRepository? _productRepo = sl<ProductRepository>();

  editProduct(Map<String, dynamic> _params) async {
    emit(Result.isLoading());
    emit(await _productRepo!.editProduct(_params));
  }
}
