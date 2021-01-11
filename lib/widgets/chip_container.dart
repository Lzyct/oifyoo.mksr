import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 03/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ChipContainer extends StatefulWidget {
  ChipContainer({Key key, this.children}) : super(key: key);
  final List<Widget> children;

  @override
  _ChipContainerState createState() => _ChipContainerState();
}

class _ChipContainerState extends State<ChipContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      constraints: BoxConstraints(
        minHeight: Dimens.height30,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radius)),
          border: Border.all(color: Palette.colorHint)),
      child: Wrap(
        children: widget.children,
      ),
    );
  }
}
