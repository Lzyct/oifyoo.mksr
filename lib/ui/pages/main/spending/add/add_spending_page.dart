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
class AddSpendingPage extends StatefulWidget {
  @override
  _AddSpendingPageState createState() => _AddSpendingPageState();
}

class _AddSpendingPageState extends State<AddSpendingPage> {
  late AddSpendingBloc _addSpendingBloc;
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
  void dispose() {
    super.dispose();
    _addSpendingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addSpending),
      avoidBottomInset: true,
      child: BlocListener(
        bloc: _addSpendingBloc,
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
                hint: Strings.spendingName,
                curFocusNode: _fnSpendingName,
                nextFocusNode: _fnPrice,
                controller: _conName,
                textInputAction: TextInputAction.next,
                validator: (String? value) => value!.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.price,
                curFocusNode: _fnPrice,
                nextFocusNode: _fnNote,
                controller: _conPrice,
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
                minLine: 6,
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
