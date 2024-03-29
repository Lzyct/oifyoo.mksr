import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 11/09/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Toast extends StatelessWidget {
  final IconData? icon;
  final Color? bgColor;
  final Color? textColor;
  final String? message;

  const Toast({Key? key, this.icon, this.bgColor, this.message, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
              ),
              SizedBox(
                width: 4.w,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 250.w),
                child: Text(
                  message!,
                  style: TextStyles.text.copyWith(color: textColor),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  softWrap: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
