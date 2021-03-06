import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class CustomTab extends StatefulWidget {
  CustomTab({
    Key key,
    this.listData,
    this.selected,
  }) : super(key: key);
  final List<DataSelected> listData;
  final Function(int) selected;

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  var _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Dimens.tabHeight,
        margin: EdgeInsets.symmetric(vertical: context.dp8()),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: widget.listData.length,
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var _data = widget.listData[index];
            var _isSelected = _data.isSelected;

            //scroll to first / end
            try {
              logs("current index selected $index");
              if (_isSelected && index == 0) {
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 200),
                );
              } else if (_isSelected && index == widget.listData.length - 1) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 200),
                );
              }
            } catch (e) {
              logs("error $e");
            }
            return Container(
                margin: EdgeInsets.symmetric(horizontal: context.dp4()),
                child: TextButton(
                  style: ButtonStyles.primary.copyWith(
                    backgroundColor: MaterialStateProperty.all(_isSelected
                        ? Palette.colorPrimary
                        : Palette.colorBackgroundAlt),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimens.radius))))),
                  onPressed: () {
                    widget.selected(widget.listData.indexOf(_data));
                    for (var item in widget.listData) {
                      setState(() {
                        if (_data.title == item.title) {
                          item.isSelected = true;
                        } else
                          item.isSelected = false;
                      });
                    }
                  },
                  child: Text(
                    _data.title,
                    style: TextStyles.white.copyWith(
                        fontSize: Dimens.fontSmall,
                        color:
                            _isSelected ? Colors.white : Palette.unSelectedTab),
                    maxLines: 1,
                  ).padding(
                      edgeInsets:
                          EdgeInsets.symmetric(horizontal: context.dp8())),
                ));
          },
        ));
  }
}
