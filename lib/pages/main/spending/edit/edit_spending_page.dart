import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class EditSpendingPage extends StatefulWidget {
  final int id;

  const EditSpendingPage({Key key, this.id}) : super(key: key);

  @override
  _EditSpendingPageState createState() => _EditSpendingPageState();
}

class _EditSpendingPageState extends State<EditSpendingPage> {
  EditSpendingBloc _editSpendingBloc;
  DetailSpendingBloc _detailSpendingBloc;
  var _formKey = GlobalKey<FormState>();

  var _conName = TextEditingController();
  var _conNote = TextEditingController();
  var _conPrice = TextEditingController();

  var _fnSpendingName = FocusNode();
  var _fnNote = FocusNode();
  var _fnPrice = FocusNode();

  SpendingEntity _spendingEntity;

  @override
  void initState() {
    super.initState();
    _editSpendingBloc = BlocProvider.of(context);
    _detailSpendingBloc = BlocProvider.of(context);
    _detailSpendingBloc.detailSpending(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.editSpending),
      avoidBottomInset: true,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
              cubit: _editSpendingBloc,
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
              cubit: _detailSpendingBloc,
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
                      _spendingEntity = state.data;

                      _conName.text = _spendingEntity.name;
                      _conNote.text = _spendingEntity.note;
                      _conPrice.text =
                          _spendingEntity.price.toString().toCurrency();
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
                height: context.dp30(),
              ),
              Button(
                title: Strings.save,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var _params = {
                      "id": widget.id,
                      "name": _conName.text,
                      "note": _conNote.text,
                      "price": _conPrice.text.toClearText()
                    };
                    logs("params $_params");
                    _editSpendingBloc.editSpending(_params);
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