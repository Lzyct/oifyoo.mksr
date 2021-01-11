import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ButtonIcon extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color color;
  final Color titleColor;
  final double fontSize;
  final String icon;
  final double iconSize;

  const ButtonIcon(
      {Key key,
      this.title,
      this.onPressed,
      this.width,
      this.height,
      this.color,
      this.titleColor,
      this.fontSize,
      this.icon, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.widthInPercent(100),
      height: height ?? Dimens.bottomButton,
      color: color??Palette.blue,
      child: FlatButton(
          onPressed: onPressed,
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(icon ?? Images.icCreateLetter,width: iconSize??null,), // TODO Use image as SVG
              SizedBox(
                width: context.dp16(),
              ),
              Text(
                title ?? "",
                style: TextStyle(
                    color: titleColor ?? Colors.white,
                    fontSize: fontSize ?? Dimens.fontLarge,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
