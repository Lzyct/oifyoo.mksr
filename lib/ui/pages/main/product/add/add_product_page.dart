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
class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late AddProductBloc _addProductBloc;
  var _formKey = GlobalKey<FormState>();

  var _conProductName = TextEditingController();
  var _conNote = TextEditingController();
  var _conSalesingPrice = TextEditingController();
  var _conQty = TextEditingController();

  var _fnProductName = FocusNode();
  var _fnNote = FocusNode();
  var _fnSalesingPrice = FocusNode();
  var _fnQty = FocusNode();

  @override
  void initState() {
    super.initState();
    _addProductBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _addProductBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addProduct),
      avoidBottomInset: true,
      child: BlocListener(
        bloc: _addProductBloc,
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
                validator: (String? value) => value!.isEmpty ? Strings.errorEmpty : null,
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
                validator: (String? value) => value!.isEmpty ? Strings.errorEmpty : null,
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
                validator: (String? value) => value!.isEmpty ? Strings.errorEmpty : null,
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
                      "productName": _conProductName.text,
                      "note": _conNote.text,
                      "sellingPrice": _conSalesingPrice.text.toClearText(),
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
