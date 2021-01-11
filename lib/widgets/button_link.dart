import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ButtonLink extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final Color titleColor;

  const ButtonLink(
      {Key key, this.title, this.onPressed, this.color, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(0.0),
        child: Text(
          title,
          style: TextStyle(
              color: titleColor ?? Palette.colorLink,
              fontSize: Dimens.fontNormal,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ));
  }
}
