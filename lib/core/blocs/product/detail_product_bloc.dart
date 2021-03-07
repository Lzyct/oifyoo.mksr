import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/entities/product_entity.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailProductBloc extends Cubit<Result<ProductEntity>> {
  DetailProductBloc() : super(Result.isLoading());

  ProductRepository? _productRepo = sl<ProductRepository>();

  detailProduct(int? _id) async {
    emit(Result.isLoading());
    emit(await _productRepo!.getDetailProduct(_id));
  }
}
