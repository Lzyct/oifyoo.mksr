import 'package:oifyoo_mksr/resources/dimens.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///*********************************************
/// Created by ukietux on 31/10/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Label extends StatelessWidget {
  final Color bgColor;
  final Color fgColor;
  final String icon;
  final String title;
  final double width;

  const Label({
    Key key,
    @required this.bgColor,
    @required this.fgColor,
    @required this.icon,
    @required this.title,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
              vertical: context.dp4(), horizontal: context.dp16()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: fgColor,
                width: context.dp12(),
              ),
              SizedBox(
                width: context.dp8(),
              ),
              Text(
                title,
                style: TextStyles.text.copyWith(
                  fontSize: Dimens.fontSmall,
                  color: fgColor,
                ),
                softWrap: true,
              )
            ],
          ),
        )
      ],
    );
  }
}
