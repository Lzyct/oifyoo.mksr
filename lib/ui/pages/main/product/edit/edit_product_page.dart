import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditProductPage extends StatefulWidget {
  final int? id;

  const EditProductPage({Key? key, this.id}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late EditProductBloc _editProductBloc;
  late DetailProductBloc _detailProductBloc;
  var _formKey = GlobalKey<FormState>();

  var _conProductName = TextEditingController();
  var _conNote = TextEditingController();
  var _conQty = TextEditingController();
  var _conSalesingPrice = TextEditingController();

  var _fnProductName = FocusNode();
  var _fnNote = FocusNode();
  var _fnQty = FocusNode();
  var _fnSalesingPrice = FocusNode();

  ProductEntity? _productEntity;

  @override
  void initState() {
    super.initState();
    _editProductBloc = BlocProvider.of(context);
    _detailProductBloc = BlocProvider.of(context);
    _detailProductBloc.detailProduct(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    _editProductBloc.close();
    _detailProductBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.editProduct),
      avoidBottomInset: true,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
              bloc: _editProductBloc,
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
                      Strings.successSaveData.toToastSuccess();
                      Navigator.pop(context);
                    }
                    break;
                }
              }),
          BlocListener(
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
                nextFocusNode: _fnQty,
                controller: _conProductName,
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.qty,
                curFocusNode: _fnQty,
                nextFocusNode: _fnSalesingPrice,
                controller: _conQty,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.sellingPrice,
                curFocusNode: _fnSalesingPrice,
                nextFocusNode: _fnNote,
                controller: _conSalesingPrice,
                prefixText: Strings.prefixRupiah,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter(),
                ],
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.note,
                curFocusNode: _fnNote,
                controller: _conNote,
                minLine: 8,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: context.dp16(),
              ),
              Button(
                title: Strings.save,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var _params = {
                      "id": widget.id,
                      "productName": _conProductName.text,
                      "note": _conNote.text,
                      "sellingPrice": _conSalesingPrice.text.toClearText(),
                      "qty": _conQty.text.toClearText()
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
