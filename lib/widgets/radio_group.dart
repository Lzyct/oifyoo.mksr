import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 08/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved

enum RGOrientation { VERTICAL, HORIZONTAL }

class RadioGroup extends StatefulWidget {
  final RGOrientation orientation;

  final List<String> titles;
  final String label;
  final Function(int) onChanged;

  RadioGroup({
    Key key,
    this.orientation = RGOrientation.HORIZONTAL,
    this.titles,
    this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  var _defaultValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
        ),
        widget.orientation == RGOrientation.VERTICAL
            ? _vertical()
            : _horizontal()
      ],
    );
  }

  _horizontal() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: Iterable<int>.generate(widget.titles.length).map((index) {
          return Row(
            children: [
              SizedBox(
                width: context.dp24(),
                child: Radio(
                  value: index,
                  groupValue: _defaultValue,
                  activeColor: Palette.colorSelected,
                  onChanged: (value) {
                    setState(() {
                      _defaultValue = value;
                      widget.onChanged(_defaultValue);
                    });
                  },
                ),
              ),
              SizedBox(width: context.dp4()),
              InkWell(
                onTap: () {
                  setState(() {
                    _defaultValue = index;
                    widget.onChanged(_defaultValue);
                  });
                },
                child: Text(
                  widget.titles[index],
                  style: TextStyles.text,
                ),
              ),
              SizedBox(width: context.dp30()),
            ],
          );
        }).toList());
  }

  _vertical() {
    return Column(
      children: Iterable<int>.generate(widget.titles.length)
          .map((index) => Row(
                children: [
                  Radio(
                    value: index,
                    groupValue: _defaultValue,
                    activeColor: Palette.colorSelected,
                    onChanged: (value) {
                      setState(() {
                        _defaultValue = value;
                        widget.onChanged(_defaultValue);
                      });
                    },
                  ),
                  SizedBox(width: context.dp4()),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _defaultValue = index;
                        widget.onChanged(_defaultValue);
                      });
                    },
                    child: Text(
                      widget.titles[index],
                      style: TextStyles.text,
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
