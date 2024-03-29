import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

class ProductPicker extends StatefulWidget {
  final String? label;
  final String? labelButton;
  final List<ProductEntity>? listProduct;
  final List<ProductEntity>? listProductFilter;
  final Function(List<ProductEntity>)? selectedProduct;
  final bool isSale;

  const ProductPicker({
    Key? key,
    this.label,
    this.labelButton,
    this.listProduct,
    this.listProductFilter,
    this.selectedProduct,
    this.isSale = true,
  }) : super(key: key);

  @override
  ProductPickerState createState() => ProductPickerState();
}

class ProductPickerState extends State<ProductPicker> {
  List<ProductEntity>? _listDataFilter = [];
  List<ProductEntity>? _listData = [];
  List<ProductEntity> _listSelected = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
        ),
        Button(
          title: widget.labelButton,
          titleColor: Colors.white,
          color: Palette.greenAlt,
          onPressed: () {
            context.bottomSheet(
              title: widget.labelButton,
              child: _bottomSheetAddProduct(),
            );
          },
        ),
      ],
    );
  }

  _bottomSheetAddProduct() {
    _listDataFilter = widget.listProductFilter;
    _listData = widget.listProduct;

    _listDataFilter = _listData;
    return StatefulBuilder(
      builder: (_, setState) {
        return Column(
          children: [
            SearchBar(
              hint: Strings.searchProduct,
              onChanged: (value) {
                logs("onChange : $value");
                setState(() {
                  if (value.isEmpty) {
                    _listDataFilter = _listData;
                  } else {
                    // Filter using Name or position
                    _listDataFilter = _listData!
                        .where((element) =>
                            !element.isSelected &&
                            (element.productName!
                                .toLowerCase()
                                .contains(value.toLowerCase())))
                        .toList();
                  }
                });
              },
            ),
            SizedBox(height: context.dp16()),
            Expanded(
              child: _listDataFilter!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _listDataFilter!.length,
                      itemBuilder: (context, index) {
                        var _price = widget.isSale
                            ? _listDataFilter![index]
                                .sellingPrice
                                .toString()
                                .toIDR()
                            : _listDataFilter![index]
                                .purchasePrice
                                .toString()
                                .toIDR();
                        logs("price $_price");
                        return Visibility(
                          visible: !_listDataFilter![index].isSelected,
                          child: InkWell(
                            onTap: () {
                              this.setState(() {
                                setState(() {
                                  if (widget.isSale &&
                                      _listDataFilter![index].qty! > 0) {
                                    _listDataFilter![index].isSelected =
                                        !_listDataFilter![index].isSelected;
                                    //update list product selected
                                    if (_listDataFilter![index].isSelected)
                                      _listSelected
                                          .add(_listDataFilter![index]);
                                    else
                                      _listSelected.removeWhere((element) =>
                                          element == _listDataFilter![index]);

                                    widget.selectedProduct!(_listSelected);
                                  } else if (!widget.isSale) {
                                    _listDataFilter![index].isSelected =
                                        !_listDataFilter![index].isSelected;
                                    //update list product selected
                                    if (_listDataFilter![index].isSelected)
                                      _listSelected
                                          .add(_listDataFilter![index]);
                                    else
                                      _listSelected.removeWhere((element) =>
                                          element == _listDataFilter![index]);

                                    widget.selectedProduct!(_listSelected);
                                  } else {
                                    Strings.qtyEmpty.toToastError();
                                  }
                                });
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _listDataFilter![index].productName!,
                                        style: TextStyles.textBold.copyWith(
                                            fontSize: Dimens.fontLarge),
                                      ),
                                    ),
                                    Text(
                                      "${Strings.qtyDot} ${_listDataFilter![index].qty}",
                                      style: TextStyles.textBold
                                          .copyWith(fontSize: Dimens.fontLarge),
                                    ),
                                  ],
                                ),
                                SizedBox(height: context.dp8()),
                                Text(
                                  _price,
                                  style: TextStyles.textHint,
                                ),
                                Divider()
                              ],
                            ).padding(
                                edgeInsets: EdgeInsets.symmetric(
                                    vertical: context.dp8())),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Empty(
                        errorMessage: Strings.productNotFound,
                      ),
                    ),
            ),
            Button(
              title: Strings.close,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
