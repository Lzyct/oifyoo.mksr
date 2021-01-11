import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukietux on 29/10/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
///

enum DTType { DATE, TIME }

/// This show custom Text for TextDate with icon
class TextDT extends StatefulWidget {
  TextDT(
      {Key key,
      this.hint,
      this.content,
      this.type = DTType.DATE,
      this.isHintVisible = true})
      : super(key: key);
  final String hint;
  final String content;
  final DTType type;
  final bool isHintVisible;

  @override
  _TextDTState createState() => _TextDTState();
}

class _TextDTState extends State<TextDT> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.isHintVisible,
            child: Text(
              widget.hint ?? "",
              style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
            ),
          ),
          SizedBox(
            height: context.dp4(),
          ),
          Row(
            children: [
              // SvgPicture.asset(widget.type == DTType.DATE
              //     ? Images.icCalendar
              //     : Images.icClock),// TODO Use image as SVG
              SizedBox(width: context.dp4()),
              Text(
                widget.content,
                style: TextStyles.text.copyWith(fontSize: Dimens.fontSmall),
              ),
            ],
          )
        ],
      ),
    );
  }
}
