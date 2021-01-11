import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 08/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class CheckBox extends StatefulWidget {
  CheckBox({
    Key key,
    this.title,
    this.fontSize,
    this.onChanged,
  }) : super(key: key);
  final String title;
  final double fontSize;
  final Function(bool) onChanged;

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.dp24(),
          child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.comfortable,
              value: _isSelected,
              activeColor: Palette.colorPrimary,
              onChanged: (value) {
                setState(() {
                  _isSelected = value;
                  widget.onChanged(_isSelected);
                });
              }),
        ),
        SizedBox(
          width: context.dp12(),
        ),
        GestureDetector(
            onTap: () {
              logs("onTap");
              setState(() {
                _isSelected = !_isSelected;
                widget.onChanged(_isSelected);
              });
            },
            child: Text(
              widget.title,
              style: TextStyles.text
                  .copyWith(fontSize: widget.fontSize ?? Dimens.fontNormal),
            )),
      ],
    );
  }
}
