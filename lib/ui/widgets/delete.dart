import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/13/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class Delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: context.dp16()),
          Text(
            Strings.delete,
            style: TextStyles.white,
          )
        ],
      ),
    );
  }
}
