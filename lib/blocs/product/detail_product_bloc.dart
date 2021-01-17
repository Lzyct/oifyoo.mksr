import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/product_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailProductBloc extends Cubit<Resources<ProductEntity>> {
  DetailProductBloc() : super(Resources.loading());

  var _productRepo = sl<ProductRepository>();

  detailProduct(int _id) async {
    emit(Resources.loading());
    emit(await _productRepo.getDetailProduct(_id));
  }
}
