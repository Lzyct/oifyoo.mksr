import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class DetailSalePage extends StatefulWidget {
  final String? transactionNumber;
  final String? total;
  final String? discount;

  const DetailSalePage(
      {Key? key, this.transactionNumber, this.total, this.discount})
      : super(key: key);

  @override
  _DetailSalePageState createState() => _DetailSalePageState();
}

class _DetailSalePageState extends State<DetailSalePage> {
  late DetailSaleBloc _detailSaleBloc;
  GlobalKey _globalKey = new GlobalKey();

  String? _selectedStatus = Strings.listStatus[0];
  String? _note = "";
  String? _buyer = "";
  late var _total;
  var _purchaseDate = "";
  List<TransactionEntity>? _listSelectedProduct = [];

  @override
  void initState() {
    super.initState();

    _detailSaleBloc = BlocProvider.of(context);
    _detailSaleBloc = BlocProvider.of(context);
    _detailSaleBloc.detailSale(widget.transactionNumber);

    _total = (widget.total!.toClearText().toInt() -
            widget.discount!.toClearText().toInt())
        .toString()
        .toIDR();
  }

  @override
  void dispose() {
    super.dispose();
    _detailSaleBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      isPadding: false,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Palette.colorPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.colorText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
        title: Text(
          Strings.detailSale,
          style: TextStyles.text.copyWith(
            fontSize: Dimens.fontLarge,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.share_rounded,
                color: Palette.colorText,
              ),
              onPressed: () async {
                await _shareStruck();
              })
        ],
      ),
      child: BlocListener(
        bloc: _detailSaleBloc,
        listener: (_, dynamic state) {
          switch (state.status) {
            case Status.LOADING:
              {
                Strings.pleaseWait.toToastLoading();
              }
              break;
            case Status.ERROR:
              {
                state.message.toString().toToastError();
              }
              break;
            case Status.SUCCESS:
              {
                setState(() {
                  _listSelectedProduct = state.data;
                  _note = _listSelectedProduct![0].note;
                  _buyer = _listSelectedProduct![0].buyer;
                  _selectedStatus = _listSelectedProduct![0].status;
                  _purchaseDate =
                      _listSelectedProduct![0].createdAt!.toDateTime();
                  logs("data ${_listSelectedProduct![0]}");
                });
              }
              break;
          }
        },
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Palette.colorPrimary,
                  padding: EdgeInsets.only(
                      top: context.dp20(), bottom: context.dp8()),
                  child: Center(
                    child: Image.asset(
                      Images.icLogo,
                      height: Dimens.height30,
                    ),
                  ),
                ),
                Column(
                  children: [
                    TextD(
                      hint: Strings.transactionNumber,
                      content: widget.transactionNumber,
                    ),
                    SizedBox(height: context.dp8()),
                    Text(
                      Strings.productList,
                      style: TextStyles.textHint,
                    ),
                    SizedBox(height: context.dp8()),
                    ListView.builder(
                        itemCount: _listSelectedProduct!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return _listItem(index);
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Strings.subTotalDot}",
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        ),
                        Text(
                          widget.total!,
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        )
                      ],
                    ),
                    SizedBox(height: context.dp8()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Strings.discountDot}",
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        ),
                        Text(
                          widget.discount!,
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        )
                      ],
                    ),
                    SizedBox(height: context.dp8()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Strings.totalDot}",
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        ),
                        Text(
                          _total,
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        )
                      ],
                    ),
                    SizedBox(height: context.dp16()),
                    TextD(
                      hint: Strings.note,
                      content: _note!.isEmpty ? "-" : _note,
                    ),
                    TextD(
                      hint: Strings.buyerName,
                      content: _buyer,
                    ),
                    TextD(
                      hint: Strings.status,
                      content: _selectedStatus,
                    ),
                    TextD(
                      hint: Strings.purchaseDate,
                      content: _purchaseDate,
                    ),
                  ],
                ).padding(edgeInsets: EdgeInsets.all(context.dp16()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listItem(int index) {
    int _qty = _listSelectedProduct![index].qty!;
    int _price = _listSelectedProduct![index].price!;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_listSelectedProduct![index].productName!,
                    style: TextStyles.textBold),
                SizedBox(height: context.dp8()),
                Text(
                  "$_qty@${_price.toString().toCurrency()}",
                  style: TextStyles.text,
                ),
              ],
            )),
            Text(
              "${(_qty * _price).toString().toIDR()}",
              style: TextStyles.text.copyWith(fontSize: Dimens.fontLarge),
            )
          ],
        ),
        Divider()
      ],
    );
  }

  Future<void> _shareStruck() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as Future<ByteData>);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    var _tempDir = await getTemporaryDirectory();
    File _file = await File("${_tempDir.path}/ss.png").create();
    _file.writeAsBytesSync(pngBytes);

    // logs("file path ${_file.}");
    logs("File size ${_file.lengthSync()}");

    Share.shareFiles([_file.path]);
    print(pngBytes);
  }
}
