import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukietux on 11/15/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class TextI extends StatelessWidget {
  final String img;
  final String title;
  final double titleSize;
  final double imgSize;
  final Color titleColor;

  const TextI({
    Key key,
    this.img,
    this.title,
    this.titleSize,
    this.imgSize,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   img ?? Images.icCalendar,
        //   width: imgSize ?? context.dp14(),
        // ), // TODO Use image as SVG
        SizedBox(width: context.dp8()),
        Expanded(
            child: Text(
          title ?? "",
          style: TextStyles.white.copyWith(
              fontSize: titleSize ?? Dimens.fontSmall,
              color: titleColor ?? Colors.white),
        )),
      ],
    );
  }
}
