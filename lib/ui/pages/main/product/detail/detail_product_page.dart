import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class DetailProductPage extends StatefulWidget {
  final int? id;

  const DetailProductPage({Key? key, this.id}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  DetailProductBloc? _detailProductBloc;

  var _conProductName = TextEditingController();
  var _conNote = TextEditingController();
  var _conQty = TextEditingController();
  var _conSalesingPrice = TextEditingController();
  var _conPurchasePrice = TextEditingController();
  var _conPurchaseDate = TextEditingController();

  ProductEntity? _productEntity;

  @override
  void initState() {
    super.initState();
    _detailProductBloc = BlocProvider.of(context);
    _detailProductBloc!.detailProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: context.appBar(title: Strings.detailProduct),
        child: BlocListener(
          bloc: _detailProductBloc,
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
                  _productEntity = state.data;

                  _conProductName.text = _productEntity!.productName!;
                  _conNote.text = _productEntity!.note!;
                  _conQty.text = _productEntity!.qty.toString();
                  _conSalesingPrice.text =
                      _productEntity!.sellingPrice.toString().toCurrency();
                  _conPurchasePrice.text =
                      _productEntity!.purchasePrice.toString().toCurrency();
                  _conPurchaseDate.text =
                      _productEntity!.createdAt!.toDateTime();
                }
                break;
            }
          },
          child: Column(
            children: [
              TextF(
                hint: Strings.productName,
                curFocusNode: DisableFocusNode(),
                controller: _conProductName,
              ),
              TextF(
                hint: Strings.note,
                curFocusNode: DisableFocusNode(),
                controller: _conNote,
              ),
              TextF(
                hint: Strings.qty,
                curFocusNode: DisableFocusNode(),
                controller: _conQty,
              ),
              TextF(
                hint: Strings.sellingPrice,
                curFocusNode: DisableFocusNode(),
                controller: _conSalesingPrice,
                prefixText: Strings.prefixRupiah,
              ),
              TextF(
                hint: Strings.purchasePrice,
                curFocusNode: DisableFocusNode(),
                controller: _conPurchasePrice,
                prefixText: Strings.prefixRupiah,
              ),
            ],
          ),
        ));
  }
}
