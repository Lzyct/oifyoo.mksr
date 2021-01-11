import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 31/10/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class TabView extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;

  const TabView({
    Key key,
    @required this.tabs,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      controller: controller,
      isScrollable: true,
      indicator: TabIndicator(radius: 5, color: Palette.colorSelected),
      labelPadding: EdgeInsets.symmetric(
          vertical: context.dp24(), horizontal: context.dp8()),
      unselectedLabelStyle: TextStyles.textHint,
      unselectedLabelColor: Palette.colorHint,
      labelStyle: TextStyles.text,
      labelColor: Palette.colorText,
    ).padding(edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16()));
  }
}
