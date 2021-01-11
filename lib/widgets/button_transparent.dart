import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ButtonTransparent extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;

  const ButtonTransparent({
    Key key,
    this.title,
    this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.widthInPercent(100),
      height: height ?? 40.w,
      child: FlatButton(
          color: Colors.transparent,
          onPressed: onPressed,
          focusColor: Colors.transparent,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(context.dp4())),
          padding: EdgeInsets.all(0.0),
          child: Text(
            title,
            style: TextStyle(
                color: Palette.colorText,
                fontSize: Dimens.fontNormal,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          )),
    );
  }
}
