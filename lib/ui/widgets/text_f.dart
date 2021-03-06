import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukieTux on 22/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class TextF extends StatefulWidget {
  const TextF(
      {Key key,
      this.curFocusNode,
      this.nextFocusNode,
      this.hint,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.textInputAction,
      this.obscureText,
      this.suffixIcon,
      this.controller,
      this.onTap,
      this.textAlign,
      this.enable,
      this.inputFormatter,
      this.minLine,
      this.maxLine,
      this.isHintVisible = true,
      this.prefixText})
      : super(key: key);

  final FocusNode curFocusNode;
  final FocusNode nextFocusNode;
  final String hint;
  final Function(String) validator;
  final Function(String) onChanged;
  final Function onTap;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool obscureText;
  final int minLine;
  final int maxLine;
  final Widget suffixIcon;
  final TextAlign textAlign;
  final bool enable;
  final List<TextInputFormatter> inputFormatter;
  final bool isHintVisible;
  final String prefixText;

  @override
  _TextFState createState() => _TextFState();
}

class _TextFState extends State<TextF> {
  bool isFocus = false;
  String currentVal = "";
  Color _color = Palette.colorHint;

  @override
  void initState() {
    super.initState();
    widget.curFocusNode.addListener(() {
      logs("message");
      setState(() {
        if (widget.curFocusNode.hasFocus)
          _color = Palette.colorPrimary;
        else
          _color = Palette.colorHint;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.isHintVisible,
            child: Text(
              widget.hint ?? "",
              style: TextStyles.textHint
                  .copyWith(fontSize: Dimens.fontSmall, color: _color),
            ),
          ),
          TextFormField(
            key: widget.key,
            enabled: widget.enable,
            obscureText: widget.obscureText ?? false,
            focusNode: widget.curFocusNode,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlign ?? TextAlign.start,
            minLines: widget.minLine ?? 1,
            maxLines: widget.maxLine ?? 10,
            inputFormatters: widget.inputFormatter,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              color: Palette.colorText,
              fontSize: Dimens.fontNormal,
            ),
            cursorColor: Palette.colorText,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                suffixIcon: widget.suffixIcon,
                prefixText: widget.prefixText ?? "",
                contentPadding: EdgeInsets.symmetric(
                    vertical: context.dp8(), horizontal: context.dp12()),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.dp4()),
                  borderSide: BorderSide(
                    color: Palette.borderTextF,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(context.dp4()),
                    borderSide: BorderSide(
                      color: Palette.red,
                      width: 1.0,
                    )),
                errorBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(context.dp4()),
                    borderSide: BorderSide(
                      color: Palette.red,
                      width: 1.0,
                    )),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.dp4()),
                  borderSide: BorderSide(
                    color: Palette.colorPrimary,
                    width: 1.0,
                  ),
                )),
            validator: widget.validator,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onFieldSubmitted: (value) {
              setState(() {
                fieldFocusChange(
                    context, widget.curFocusNode, widget.nextFocusNode);
              });
            },
          ).margin(edgeInsets: EdgeInsets.symmetric(vertical: context.dp8()))
        ],
      ),
    );
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
