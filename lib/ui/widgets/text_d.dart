import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class TextD extends StatefulWidget {
  TextD(
      {Key? key,
      this.hint,
      this.content,
      this.contentColor,
      this.contentSize,
      this.isFirst = false,
      this.hintColor,
      this.onTap})
      : super(key: key);
  final String? hint;
  final String? content;
  final Color? contentColor;
  final Color? hintColor;
  final double? contentSize;
  final bool isFirst;
  final Function? onTap;

  @override
  _TextDState createState() => _TextDState();
}

class _TextDState extends State<TextD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: context.dp8(), top: (widget.isFirst) ? 0 : context.dp8()),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hint ?? "",
            style: TextStyles.textHint.copyWith(
              fontSize: Dimens.fontSmall,
              color: widget.hintColor ?? Palette.colorHint,
            ),
          ),
          SizedBox(
            height: context.dp4(),
          ),
          InkWell(
            onTap: widget.onTap as void Function()?,
            child: Text(
              widget.content!,
              style: TextStyles.text.copyWith(
                  color: widget.contentColor ?? Palette.colorText,
                  fontSize: widget.contentSize ?? Dimens.fontNormal),
            ),
          )
        ],
      ),
    );
  }
}
