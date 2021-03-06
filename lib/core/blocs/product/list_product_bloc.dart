import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/entities/product_entity.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListProductBloc extends Cubit<Result<List<ProductEntity>>> {
  ListProductBloc() : super(Result.isLoading());

  var _productRepo = sl<ProductRepository>();

  listProduct(String _productName) async {
    emit(Result.isLoading());
    emit(await _productRepo.getListProduct(_productName));
  }
}
