import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/pages/main/main.dart';

enum NavigationEvents {
  HomePage,
  SalePage,
  PurchasePage,
  SpendingPage,
  Product,
}

class NavDrawerBloc extends Cubit<Widget> {
  NavDrawerBloc()
      : super(MultiBlocProvider(providers: [
          BlocProvider(create: (_) => TotalPurchaseBloc()),
          BlocProvider(create: (_) => TotalSaleBloc()),
          BlocProvider(create: (_) => TotalSpendingBloc()),
        ], child: HomePage()));

  openDrawer(NavigationEvents event) {
    switch (event) {
      case NavigationEvents.HomePage:
        emit(MultiBlocProvider(providers: [
          BlocProvider(create: (_) => TotalPurchaseBloc()),
          BlocProvider(create: (_) => TotalSaleBloc()),
          BlocProvider(create: (_) => TotalSpendingBloc()),
        ], child: HomePage()));
        break;
      case NavigationEvents.SalePage:
        emit(MultiBlocProvider(providers: [
          BlocProvider(create: (_) => ListSaleBloc()),
          BlocProvider(create: (_) => DeleteSaleBloc())
        ], child: ListSalePage()));
        break;
      case NavigationEvents.PurchasePage:
        emit(MultiBlocProvider(providers: [
          BlocProvider(create: (_) => ListPurchaseBloc()),
          BlocProvider(create: (_) => DeletePurchaseBloc())
        ], child: ListPurchasePage()));
        break;
      case NavigationEvents.Product:
        emit(MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ListProductBloc()),
            BlocProvider(create: (_) => DeleteProductBloc())
          ],
          child: ListProductPage(),
        ));
        break;
      case NavigationEvents.SpendingPage:
        emit(MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ListSpendingBloc()),
            BlocProvider(create: (_) => DeleteSpendingBloc())
          ],
          child: ListSpendingPage(),
        ));
        break;
    }
  }
}
