import 'package:get_it/get_it.dart';
import 'package:oifyoo_mksr/data/repositories/repositories.dart';
import 'package:oifyoo_mksr/data/sources/sources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di.dart';

var sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerFactory<API>(() => API());
  sl.registerFactory<DbHelper>(() => DbHelper());

  // register db query
  sl.registerLazySingleton(() => ProductTransaction());
  sl.registerLazySingleton(() => SaleTransaction());
  sl.registerLazySingleton(() => PurchaseTransaction());
  sl.registerLazySingleton(() => SpendingTransaction());
  sl.registerLazySingleton(() => HomeTransaction());

  // register  Repositories
  sl.registerLazySingleton(() => ProductRepository());
  sl.registerLazySingleton(() => SaleRepository());
  sl.registerLazySingleton(() => PurchaseRepository());
  sl.registerLazySingleton(() => SpendingRepository());
  sl.registerLazySingleton(() => HomeRepository());
}

//register prefManager
Future<void> initPrefManager() async {
  var _initPrefManager = await SharedPreferences.getInstance();
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}
