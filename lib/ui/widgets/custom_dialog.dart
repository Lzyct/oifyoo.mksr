import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukietux on 19/06/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class CustomDialog extends StatefulWidget {
  final Widget content;
  final bool showClose;
  final double width;
  final double height;
  final Function onBackPressed;
  final String title;

  const CustomDialog(
      {Key key,
      @required this.content,
      this.showClose,
      this.width,
      this.height,
      this.onBackPressed,
      this.title})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final radius = 5.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      //this right here
      textStyle: TextStyles.text,
      isDestructiveAction: true,
      isDefaultAction: true,
      child: Container(
          width: widget.width ?? context.widthInPercent(90),
          child: Column(
            children: [
              Container(
                  height: context.dp32(),
                  width: widget.width ?? context.widthInPercent(90),
                  decoration: BoxDecoration(
                      color: Palette.colorPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      )),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          widget.title ?? "",
                          style: TextStyles.white
                              .copyWith(fontSize: Dimens.fontLarge),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: context.dp16(),
                        child: SizedBox(
                          width: context.dp24(),
                          child: TextButton(
                            style: ButtonStyles.primary,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: widget.onBackPressed ??
                                () {
                                  Navigator.pop(context);
                                },
                          ),
                        ),
                      )
                    ],
                  )),
              Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                  child: widget.content)
            ],
          )),
    );
  }
}
