import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';
import 'package:oktoast/oktoast.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TotalPurchaseBloc _totalPurchaseBloc;
  TotalSaleBloc _totalSaleBloc;
  TotalSpendingBloc _totalSpendingBloc;

  int _totalIncoming = 0;
  int _totalSpending = 0;
  int _total = 0;

  var _totalSaleEntity = HomeEntity();
  var _totalSpendingEntity = HomeEntity();
  var _totalPurchaseEntity = HomeEntity();

  @override
  void initState() {
    super.initState();
    _totalPurchaseBloc = BlocProvider.of<TotalPurchaseBloc>(context);
    _totalSaleBloc = BlocProvider.of<TotalSaleBloc>(context);
    _totalSpendingBloc = BlocProvider.of<TotalSpendingBloc>(context);
    _initData();
  }

  _initData() async {
    await _totalPurchaseBloc.totalPurchase();
    await _totalSpendingBloc.totalSpending();
    await _totalSaleBloc.totalSale();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: null,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: _totalPurchaseBloc,
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
                    dismissAllToast();
                    setState(() {
                      _totalPurchaseEntity = state.data;
                      _totalSpending += _totalPurchaseEntity.total;
                    });
                  }
                  break;
              }
            },
          ),
          BlocListener(
            cubit: _totalSpendingBloc,
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
                    dismissAllToast();
                    try {
                      setState(() {
                        _totalSpendingEntity = state.data;
                        _totalSpending += _totalSpendingEntity.total;
                      });
                    } catch (e) {
                      logs("error $e");
                    }
                  }
                  break;
              }
            },
          ),
          BlocListener(
            cubit: _totalSaleBloc,
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
                    dismissAllToast();
                    setState(() {
                      _totalSaleEntity = state.data;
                      logs("total ${_totalSaleEntity.total}");
                      _totalIncoming += _totalSaleEntity.total;
                      _total = _totalIncoming - _totalSpending;
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
            Text(
              DateTime.now().toString().toMonthYearText(),
              style: TextStyles.textBold.copyWith(fontSize: Dimens.fontLarge2),
            ),
            CardView(
                margin: EdgeInsets.symmetric(vertical: context.dp30()),
                child: Container(
                  padding: EdgeInsets.all(context.dp16()),
                  color: Palette.blueSoft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _total.toString().toIDR(),
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge2),
                      ),
                      Icon(
                        _total <= 0
                            ? Icons.trending_down_rounded
                            : Icons.trending_up_rounded,
                        color: _total <= 0 ? Palette.red : Palette.green,
                        size: context.dp30(),
                      )
                    ],
                  ),
                ),
                onTap: () {}),
            Text(
              "${Strings.lastUpdate} ${_totalSaleEntity.updatedAt.toString().toDateTime()}",
              style: TextStyles.textHint.copyWith(
                  fontStyle: FontStyle.italic, fontSize: Dimens.fontSmall),
            ),
            CardView(
                margin: EdgeInsets.symmetric(vertical: context.dp8()),
                child: Container(
                  width: context.widthInPercent(100),
                  color: Palette.greenAltSoft,
                  padding: EdgeInsets.all(context.dp16()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.totalIncomeMonth),
                      Text(
                        _totalIncoming.toString().toIDR(),
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge1),
                      )
                    ],
                  ),
                ),
                onTap: null),
            SizedBox(height: context.dp16()),
            Text(
              "${Strings.lastUpdate} ${_totalSpendingEntity.updatedAt.toString().toDateTime()}",
              style: TextStyles.textHint.copyWith(
                  fontStyle: FontStyle.italic, fontSize: Dimens.fontSmall),
            ),
            CardView(
                margin: EdgeInsets.symmetric(vertical: context.dp8()),
                child: Container(
                  color: Palette.redSoft,
                  width: context.widthInPercent(100),
                  padding: EdgeInsets.all(context.dp16()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.totalSpendingMonth),
                      Text(
                        _totalSpending.toString().toIDR(),
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge1),
                      )
                    ],
                  ),
                ),
                onTap: null)
          ],
        ),
      ),
    );
  }
}
