import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DeleteProductBloc extends Cubit<Resources<dynamic>> {
  DeleteProductBloc() : super(Resources.loading());

  var _patientRepo = sl<ProductRepository>();

  deleteProduct(int _id) async {
    emit(Resources.loading());
    emit(await _patientRepo.deleteProduct(_id));
  }
}
