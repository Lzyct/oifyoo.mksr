import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  AddProductBloc _addProductBloc;
  var _formKey = GlobalKey<FormState>();

  var _conProductName = TextEditingController();
  var _conNote = TextEditingController();
  var _conSellingPrice = TextEditingController();
  var _conQty = TextEditingController();

  var _fnProductName = FocusNode();
  var _fnNote = FocusNode();
  var _fnSellingPrice = FocusNode();
  var _fnQty = FocusNode();

  @override
  void initState() {
    super.initState();
    _addProductBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addProduct),
      avoidBottomInset: true,
      child: BlocListener(
        cubit: _addProductBloc,
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
                nextFocusNode: _fnSellingPrice,
                controller: _conQty,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  _conQty.text = _conQty.text.toCurrency();
                  _conQty.selection = TextSelection.fromPosition(
                      TextPosition(offset: _conQty.text.length));
                },
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.sellingPrice,
                curFocusNode: _fnSellingPrice,
                nextFocusNode: _fnNote,
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
                  if (_formKey.currentState.validate()) {
                    var _params = {
                      "productName": _conProductName.text,
                      "note": _conNote.text,
                      "sellingPrice": _conSellingPrice.text.toClearText(),
                      "qty": _conQty.text.toClearText()
                    };
                    _addProductBloc.addProduct(_params);
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
