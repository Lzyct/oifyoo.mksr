import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditPurchasePage extends StatefulWidget {
  final String transactionNumber;
  final String total;

  const EditPurchasePage({Key key, this.transactionNumber, this.total})
      : super(key: key);

  @override
  _EditPurchasePageState createState() => _EditPurchasePageState();
}

class _EditPurchasePageState extends State<EditPurchasePage> {
  EditPurchaseBloc _editPurchaseBloc;
  DetailSaleBloc _detailSaleBloc;

  var _selectedStatus = Strings.listStatus[0];
  var _note = "";
  var _buyer = "";
  List<TransactionEntity> _listSelectedProduct = [];

  @override
  void initState() {
    super.initState();

    _editPurchaseBloc = BlocProvider.of(context);
    _detailSaleBloc = BlocProvider.of(context);
    _detailSaleBloc.detailSale(widget.transactionNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.editPurchase),
      avoidBottomInset: true,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: _editPurchaseBloc,
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
                    Strings.successSaveData.toToastSuccess();
                    Navigator.pop(context);
                  }
                  break;
              }
            },
          ),
          BlocListener(
            cubit: _detailSaleBloc,
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
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextD(
              hint: Strings.transactionNumber,
              content: widget.transactionNumber,
            ),
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
                  style:
                      TextStyles.textBold.copyWith(fontSize: Dimens.fontLarge),
                ),
                Text(
                  widget.total,
                  style:
                      TextStyles.textBold.copyWith(fontSize: Dimens.fontLarge),
                )
              ],
            ),
            SizedBox(height: context.dp16()),
            TextD(
              hint: Strings.note,
              content: _note,
            ),
            TextD(
              hint: Strings.buyerName,
              content: _buyer,
            ),
            DropDown(
              hint: Strings.status,
              value: _selectedStatus,
              items: Strings.listStatus?.map((item) {
                return DropdownMenuItem(
                  child: Text(item, style: TextStyles.text),
                  value: item,
                );
              })?.toList(),
              onChanged: (value) {
                _selectedStatus = value;
              },
            ),
            SizedBox(
              height: context.dp16(),
            ),
            Button(
                title: Strings.save,
                onPressed: () {
                  var _params = {
                    "transactionNumber": widget.transactionNumber,
                    "status": _selectedStatus,
                  };
                  _editPurchaseBloc.editPurchase(_params);
                })
          ],
        ),
      ),
    );
  }

  _listItem(int index) {
    int _qty = _listSelectedProduct[index].qty;
    int _price = _listSelectedProduct[index].productPrice;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 5,
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
}
