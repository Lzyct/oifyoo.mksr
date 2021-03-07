import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/13/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class Edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(width: context.dp16()),
          Text(
            Strings.edit,
            style: TextStyles.white,
          )
        ],
      ),
    );
  }
}
