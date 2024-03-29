import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/core/core.dart';


///*********************************************
/// Created by Mudassir (ukietux) on 1/17/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class QuantityPicker extends StatefulWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const QuantityPicker({
    Key? key,
    this.textEditingController,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            style: ButtonStyles.primary.copyWith(
                shape: MaterialStateProperty.all(CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Palette.red),
                minimumSize: MaterialStateProperty.all(Size(0, context.dp25())),
                padding:
                    MaterialStateProperty.all(EdgeInsets.all(context.dp6()))),
            onPressed: () {
              logs("onPressed");
              var _count = widget.textEditingController!.text.toInt();
              _count--;
              widget.textEditingController!.text = _count.toString();
              widget.onChanged!(_count.toString());
            },
            child: SvgPicture.asset(
              Images.icRemove,
              height: context.dp12(),
            )),
        SizedBox(
            width: context.widthInPercent(10),
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                isDense: true,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(context.dp4()),
                  borderSide: BorderSide(
                    color: Palette.colorPrimary,
                    width: 1.0,
                  ),
                ),
              ),
              style: TextStyles.textBold.copyWith(fontSize: Dimens.fontLarge),
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                logs("onChanged $value");
              },
            )),
        TextButton(
            style: ButtonStyles.primary.copyWith(
                shape: MaterialStateProperty.all(CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Palette.green),
                minimumSize: MaterialStateProperty.all(Size(0, context.dp25())),
                padding:
                    MaterialStateProperty.all(EdgeInsets.all(context.dp6()))),
            onPressed: () {
              logs("onPressed");
              var _count = widget.textEditingController!.text.toInt();
              _count++;

              widget.textEditingController!.text = _count.toString();
              widget.onChanged!(_count.toString());
            },
            child: SvgPicture.asset(
              Images.icAdd,
              height: context.dp12(),
            )),
      ],
    );
  }
}
