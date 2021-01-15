import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/product_entity.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListProductBloc extends Cubit<Resources<List<ProductEntity>>> {
  ListProductBloc() : super(Resources.loading());

  var _patientRepo = sl<ProductRepository>();

  listProduct(String _productName) async {
    emit(Resources.loading());
    emit(await _patientRepo.getListProduct(_productName));
  }
}
