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
class DetailSpendingPage extends StatefulWidget {
  final int? id;

  const DetailSpendingPage({Key? key, this.id}) : super(key: key);

  @override
  _DetailSpendingPageState createState() => _DetailSpendingPageState();
}

class _DetailSpendingPageState extends State<DetailSpendingPage> {
  DetailSpendingBloc? _detailSpendingBloc;

  var _conName = TextEditingController();
  var _conNote = TextEditingController();
  var _conPrice = TextEditingController();

  SpendingEntity? _spendingEntity;

  @override
  void initState() {
    super.initState();
    _detailSpendingBloc = BlocProvider.of(context);
    _detailSpendingBloc!.detailSpending(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: context.appBar(title: Strings.detailSpending),
        child: BlocListener(
          bloc: _detailSpendingBloc,
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
                  _spendingEntity = state.data;

                  _conName.text = _spendingEntity!.name!;
                  _conNote.text = _spendingEntity!.note!;
                  _conPrice.text =
                      _spendingEntity!.price.toString().toCurrency();
                }
                break;
            }
          },
          child: Column(
            children: [
              TextF(
                hint: Strings.spendingName,
                curFocusNode: DisableFocusNode(),
                controller: _conName,
              ),
              TextF(
                hint: Strings.note,
                curFocusNode: DisableFocusNode(),
                controller: _conNote,
              ),
              TextF(
                hint: Strings.price,
                curFocusNode: DisableFocusNode(),
                controller: _conPrice,
                prefixText: Strings.prefixRupiah,
              ),
            ],
          ),
        ));
  }
}
