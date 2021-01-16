import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/entities/product_entity.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditProductPage extends StatefulWidget {
  final int id;

  const EditProductPage({Key key, this.id}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  EditProductBloc _editProductBloc;
  DetailProductBloc _detailProductBloc;
  var _formKey = GlobalKey<FormState>();

  var _conProductName = TextEditingController();
  var _conNote = TextEditingController();
  var _conStock = TextEditingController();
  var _conCapitalPrice = TextEditingController();
  var _conSellingPrice = TextEditingController();

  var _fnProductName = FocusNode();
  var _fnNote = FocusNode();
  var _fnStock = FocusNode();
  var _fnCapitalPrice = FocusNode();
  var _fnSellingPrice = FocusNode();

  ProductEntity _productEntity;

  @override
  void initState() {
    super.initState();
    _editProductBloc = BlocProvider.of(context);
    _detailProductBloc = BlocProvider.of(context);
    _detailProductBloc.detailProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.editProduct),
      child: MultiBlocListener(
        listeners: [
          BlocListener(
              cubit: _editProductBloc,
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
              }),
          BlocListener(
              cubit: _detailProductBloc,
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
                      _productEntity = state.data;

                      _conProductName.text = _productEntity.productName;
                      _conNote.text = _productEntity.note;
                      _conStock.text = _productEntity.stock.toString();
                      _conCapitalPrice.text =
                          _productEntity.capitalPrice.toString().toCurrency();
                      _conSellingPrice.text =
                          _productEntity.sellingPrice.toString().toCurrency();
                    }
                    break;
                }
              })
        ],
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextF(
                hint: Strings.productName,
                curFocusNode: _fnProductName,
                nextFocusNode: _fnNote,
                controller: _conProductName,
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.note,
                curFocusNode: _fnNote,
                nextFocusNode: _fnStock,
                controller: _conNote,
                textInputAction: TextInputAction.next,
              ),
              TextF(
                hint: Strings.stock,
                curFocusNode: _fnStock,
                nextFocusNode: _fnCapitalPrice,
                controller: _conStock,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.capitalPrice,
                curFocusNode: _fnCapitalPrice,
                nextFocusNode: _fnSellingPrice,
                controller: _conCapitalPrice,
                prefixText: Strings.prefixRupiah,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  _conCapitalPrice.text = _conCapitalPrice.text.toCurrency();
                  _conCapitalPrice.selection = TextSelection.fromPosition(
                      TextPosition(offset: _conCapitalPrice.text.length));
                },
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.sellingPrice,
                curFocusNode: _fnSellingPrice,
                controller: _conSellingPrice,
                prefixText: Strings.prefixRupiah,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  _conSellingPrice.text = _conSellingPrice.text.toCurrency();
                  _conSellingPrice.selection = TextSelection.fromPosition(
                      TextPosition(offset: _conSellingPrice.text.length));
                },
                textInputAction: TextInputAction.done,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              SizedBox(
                height: context.dp30(),
              ),
              Button(
                title: Strings.save,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var _params = {
                      "id" : widget.id,
                      "productName": _conProductName.text,
                      "note": _conNote.text,
                      "stock": _conStock.text,
                      "capitalPrice": _conCapitalPrice.text.toClearText(),
                      "sellingPrice": _conSellingPrice.text.toClearText()
                    };
                    logs("params $_params");
                    _editProductBloc.editProduct(_params);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
