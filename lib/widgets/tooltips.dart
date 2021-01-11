import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 26/10/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Tooltips extends StatelessWidget {
  final Widget child;

  const Tooltips({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      decoration: BoxDecoration(
          color: Palette.toolTip,
          borderRadius: BorderRadius.all(Radius.circular(context.dp4()))),
      padding: EdgeInsets.all(context.dp16()),
      child: child,
    );
  }
}
