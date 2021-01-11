import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/pages/main/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  HomePage,
  AboutPage,
}

class NavDrawerBloc extends Cubit<Widget> {
  NavDrawerBloc() : super(HomePage());

  openDrawer(NavigationEvents event) {
    switch (event) {
      case NavigationEvents.HomePage:
        emit(HomePage());
        break;
      case NavigationEvents.AboutPage:
        emit(AboutPage());
        break;
    }
  }
}
