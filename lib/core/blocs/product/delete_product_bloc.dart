import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteProductBloc extends Cubit<Result<dynamic>> {
  DeleteProductBloc() : super(Result.isLoading());

  ProductRepository? _productRepo = sl<ProductRepository>();

  deleteProduct(int? _id) async {
    emit(Result.isLoading());
    emit(await _productRepo!.deleteProduct(_id));
  }
}
