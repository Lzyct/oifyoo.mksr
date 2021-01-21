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
class AddSpendingPage extends StatefulWidget {
  @override
  _AddSpendingPageState createState() => _AddSpendingPageState();
}

class _AddSpendingPageState extends State<AddSpendingPage> {
  AddSpendingBloc _addSpendingBloc;
  var _formKey = GlobalKey<FormState>();

  var _conName = TextEditingController();
  var _conNote = TextEditingController();
  var _conPrice = TextEditingController();

  var _fnSpendingName = FocusNode();
  var _fnNote = FocusNode();
  var _fnPrice = FocusNode();

  @override
  void initState() {
    super.initState();
    _addSpendingBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addSpending),
      avoidBottomInset: true,
      child: BlocListener(
        cubit: _addSpendingBloc,
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
                hint: Strings.spendingName,
                curFocusNode: _fnSpendingName,
                nextFocusNode: _fnNote,
                controller: _conName,
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.note,
                curFocusNode: _fnNote,
                nextFocusNode: _fnPrice,
                controller: _conNote,
                textInputAction: TextInputAction.next,
              ),
              TextF(
                hint: Strings.price,
                curFocusNode: _fnPrice,
                controller: _conPrice,
                prefixText: Strings.prefixRupiah,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  _conPrice.text = _conPrice.text.toCurrency();
                  _conPrice.selection = TextSelection.fromPosition(
                      TextPosition(offset: _conPrice.text.length));
                },
                textInputAction: TextInputAction.done,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              SizedBox(
                height: context.dp16(),
              ),
              Button(
                title: Strings.save,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var _params = {
                      "name": _conName.text,
                      "note": _conNote.text,
                      "price": _conPrice.text.toClearText()
                    };
                    _addSpendingBloc.addSpending(_params);
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
