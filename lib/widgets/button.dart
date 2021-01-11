import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color color;
  final Color titleColor;
  final double fontSize;
  final Color splashColor;

  const Button(
      {Key key,
      this.title,
      this.onPressed,
      this.width,
      this.height,
      this.color,
      this.titleColor,
      this.fontSize,
      this.splashColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.widthInPercent(100),
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      height: height ?? 40.w,
      decoration: BoxDecorations.button.copyWith(color: color ?? Palette.blue),
      child: FlatButton(
          onPressed: onPressed,
          splashColor: splashColor,
          highlightColor: splashColor,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(context.dp4())),
          padding: EdgeInsets.all(0.0),
          child: Text(
            title,
            style: TextStyle(
                color: titleColor ?? Colors.white,
                fontSize: fontSize ?? Dimens.fontNormal,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          )),
    );
  }
}
