import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/core/enums/payment_state.dart';
import 'package:oifyoo_mksr/di/di.dart';

class ListSaleBloc
    extends Cubit<Result<Map<String, Map<String, List<TransactionEntity>>>>> {
  ListSaleBloc() : super(Result.isLoading());

  SaleRepository _saleRepo = sl<SaleRepository>();

  listSale(
      {String? searchText,
      required SearchType type,
      required PaymentState paymentState}) async {
    emit(Result.isLoading());
    emit(await _saleRepo.getListSale(
        searchText: searchText, type: type, paymentState: paymentState));
  }
}
