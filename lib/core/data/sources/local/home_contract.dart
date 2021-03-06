import 'package:oifyoo_mksr/core/data/models/models.dart';

abstract class HomeContract {
  // Total Sales Section
  Future<HomeEntity> totalSalesAll();

  Future<HomeEntity> totalSalesCurMonth();

  Future<HomeEntity> totalSalesLastMonth();

  // Total Spending Section

  Future<HomeEntity> totalSpendingAll();

  Future<HomeEntity> totalSpendingCurMonth();

  Future<HomeEntity> totalSpendingLastMonth();
}
