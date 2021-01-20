import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/di/di.dart';

class DetailPurchaseBloc extends Cubit<Resources<List<TransactionEntity>>> {
  DetailPurchaseBloc() : super(Resources.loading());

  var _purchaseRepo = sl<PurchaseRepository>();

  detailPurchase(String _transactionNumber) async {
    emit(Resources.loading());
    emit(await _purchaseRepo.getDetailPurchase(_transactionNumber));
  }
}
