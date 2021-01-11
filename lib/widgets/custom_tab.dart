import 'package:oifyoo_mksr/data/models/helper/DataSelected.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///*********************************************
/// Created by ukietux on 30/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
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
          itemBuilder: (context, index) {
            var _data = widget.listData[index];
            var _isSelected = _data.isSelected;
            return Container(
                margin: EdgeInsets.symmetric(horizontal: context.dp4()),
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.radius))),
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
                  color: _isSelected
                      ? Palette.colorPrimary
                      : Palette.colorBackground,
                  child: Text(
                    _data.title,
                    style: TextStyles.white.copyWith(
                        fontSize: Dimens.fontSmall,
                        color:
                        _isSelected ? Colors.white : Palette.unSelectedTab),
                    maxLines: 1,
                  ).padding(edgeInsets: EdgeInsets.symmetric(
                      horizontal: context.dp8())),
                ));
          },
        )
    );
  }
}
