import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/blocs/product/delete_product_bloc.dart';
import 'package:oifyoo_mksr/pages/main/main.dart';

enum NavigationEvents {
  HomePage,
  SalePage,
  PurchasePage,
  Product,
}

class NavDrawerBloc extends Cubit<Widget> {
  NavDrawerBloc() : super(HomePage());

  openDrawer(NavigationEvents event) {
    switch (event) {
      case NavigationEvents.HomePage:
        emit(HomePage());
        break;
      case NavigationEvents.SalePage:
        emit(ListSalePage());
        break;
      case NavigationEvents.PurchasePage:
        emit(ListPurchasePage());
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
    }
  }
}
