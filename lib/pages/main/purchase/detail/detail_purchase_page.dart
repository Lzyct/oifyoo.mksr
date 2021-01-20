import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class DetailPurchasePage extends StatefulWidget {
  final String transactionNumber;
  final String total;

  const DetailPurchasePage({Key key, this.transactionNumber, this.total})
      : super(key: key);

  @override
  _DetailPurchasePageState createState() => _DetailPurchasePageState();
}

class _DetailPurchasePageState extends State<DetailPurchasePage> {
  DetailPurchaseBloc _detailPurchaseBloc;
  GlobalKey _globalKey = new GlobalKey();

  var _selectedStatus = Strings.listStatus[0];
  var _note = "";
  var _buyer = "";
  List<TransactionEntity> _listSelectedProduct = [];

  @override
  void initState() {
    super.initState();

    _detailPurchaseBloc = BlocProvider.of(context);
    _detailPurchaseBloc = BlocProvider.of(context);
    _detailPurchaseBloc.detailPurchase(widget.transactionNumber);
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
          Strings.detailPurchase,
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
        cubit: _detailPurchaseBloc,
        listener: (_, state) {
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
                  _note = _listSelectedProduct[0].note;
                  _buyer = _listSelectedProduct[0].buyer;
                  _selectedStatus = _listSelectedProduct[0].status;
                  logs("data ${_listSelectedProduct[0]}");
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
                        itemCount: _listSelectedProduct.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return _listItem(index);
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Strings.totalDot}",
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        ),
                        Text(
                          widget.total,
                          style: TextStyles.textBold
                              .copyWith(fontSize: Dimens.fontLarge),
                        )
                      ],
                    ),
                    SizedBox(height: context.dp16()),
                    TextD(
                      hint: Strings.note,
                      content: _note.isEmpty ? "-" : _note,
                    ),
                    TextD(
                      hint: Strings.buyerName,
                      content: _buyer,
                    ),
                    TextD(
                      hint: Strings.status,
                      content: _selectedStatus,
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
    int _qty = _listSelectedProduct[index].qty;
    int _price = _listSelectedProduct[index].sellingPrice;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_listSelectedProduct[index].productName,
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
              style: TextStyles.text,
            )
          ],
        ),
        Divider()
      ],
    );
  }

  Future<void> _shareStruck() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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
