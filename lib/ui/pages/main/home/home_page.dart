import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TotalSalesBloc _totalSaleBloc;
  late TotalSpendingBloc _totalSpendingBloc;

  SearchType _searchType = SearchType.All;

  int _totalIncomingCurMonth = 0;
  int _totalSpendingCurMonth = 0;
  int _totalCurMonth = 0;

  int _totalIncomingAll = 0;
  int _totalSpendingAll = 0;
  int _totalAll = 0;

  int _totalIncomingLastMonth = 0;
  int _totalSpendingLastMonth = 0;
  int _totalLastMonth = 0;

  String? _lastUpdateIncomingLastMonth;
  String? _lastUpdateIncomingCurMonth;
  String? _lastUpdateIncomingAll;

  String? _lastUpdateSpendingLastMonth;
  String? _lastUpdateSpendingCurMonth;
  String? _lastUpdateSpendingAll;

  var _listLabelTab = [
    DataSelected(title: Strings.all, isSelected: true),
    DataSelected(title: Strings.thisMonth, isSelected: false),
    DataSelected(title: Strings.lastMonth, isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _totalSaleBloc = BlocProvider.of<TotalSalesBloc>(context);
    _totalSpendingBloc = BlocProvider.of<TotalSpendingBloc>(context);
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _totalSaleBloc.close();
    _totalSpendingBloc.close();
  }

  _initData() async {
    // Get Spending
    await _totalSpendingBloc.totalSpendingAll();
    await _totalSpendingBloc.totalSpendingCurMonth();
    await _totalSpendingBloc.totalSpendingLastMonth();
    // Get Sales
    await _totalSaleBloc.totalSaleAll();
    await _totalSaleBloc.totalSaleCurMonth();
    await _totalSaleBloc.totalSaleLastMonth();
  }

  @override
  Widget build(BuildContext context) {
    _totalAll = _totalIncomingAll - _totalSpendingAll;
    _totalCurMonth = _totalIncomingCurMonth - _totalSpendingCurMonth;
    _totalLastMonth = _totalIncomingLastMonth - _totalSpendingLastMonth;
    return Parent(
      appBar: null,
      child: MultiBlocListener(
        listeners: [
          BlocListener<TotalSpendingBloc, Result<HomeEntity>>(
            bloc: _totalSpendingBloc,
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
                        switch (state.tag) {
                          case Strings.all:
                            {
                              _totalSpendingAll += state.data!.total!;
                              _lastUpdateSpendingAll = state.data!.updatedAt;
                            }
                            break;
                          case Strings.curMonthTag:
                            {
                              _totalSpendingCurMonth += state.data!.total!;
                              _lastUpdateSpendingCurMonth =
                                  state.data!.updatedAt;
                            }
                            break;
                          case Strings.lastMonthTag:
                            {
                              _totalSpendingLastMonth += state.data!.total!;
                              _lastUpdateSpendingLastMonth =
                                  state.data!.updatedAt;
                            }
                        }
                      });
                    } catch (e) {
                      logs("error $e");
                    }
                  }
                  break;
                case Status.UNINITIALIZED:
                  break;
                case Status.EMPTY:
                  break;
              }
            },
          ),
          BlocListener<TotalSalesBloc, Result<HomeEntity>>(
            bloc: _totalSaleBloc,
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
                      switch (state.tag) {
                        case Strings.all:
                          {
                            _totalIncomingAll += state.data!.total!;
                            _lastUpdateIncomingAll = state.data!.updatedAt;
                          }
                          break;
                        case Strings.curMonthTag:
                          {
                            _totalIncomingCurMonth += state.data!.total!;
                            _lastUpdateIncomingCurMonth = state.data!.updatedAt;
                          }
                          break;
                        case Strings.lastMonthTag:
                          {
                            _totalIncomingLastMonth += state.data!.total!;
                            _lastUpdateIncomingLastMonth =
                                state.data!.updatedAt;
                          }
                      }
                    });
                  }
                  break;
                case Status.UNINITIALIZED:
                  break;
                case Status.EMPTY:
                  break;
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTab(
              listData: _listLabelTab,
              selected: (index) {
                switch (index) {
                  case 0:
                    setState(() {
                      _searchType = SearchType.All;
                    });
                    break;
                  case 1:
                    setState(() {
                      _searchType = SearchType.Month;
                    });
                    break;
                  case 2:
                    setState(() {
                      _searchType = SearchType.Day;
                    });
                    break;
                }
              },
            ),
            _searchType == SearchType.All
                ? CardView(
                    margin: EdgeInsets.symmetric(vertical: context.dp16()),
                    child: Container(
                      padding: EdgeInsets.all(context.dp16()),
                      color: Palette.greenAltSoft,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Strings.all,
                              style: TextStyles.textBold,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _totalAll.toString().toIDR(),
                                style: TextStyles.textBold
                                    .copyWith(fontSize: Dimens.fontLarge2),
                              ),
                              Icon(
                                _totalAll <= 0
                                    ? Icons.trending_down_rounded
                                    : Icons.trending_up_rounded,
                                color: _totalAll <= 0
                                    ? Palette.red
                                    : Palette.green,
                                size: context.dp30(),
                              )
                            ],
                          ),
                          Divider(),
                          Text(
                            "${Strings.lastUpdate} ${_lastUpdateIncomingAll?.toDateTime()}",
                            style: TextStyles.textHint.copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: Dimens.fontSmall),
                          ),
                          Text(Strings.totalIncomeAll),
                          Text(
                            _totalIncomingAll.toString().toIDR(),
                            style: TextStyles.textBold.copyWith(
                                fontSize: Dimens.fontLarge1,
                                color: Palette.green),
                          ),
                          Divider(),
                          Text(
                            "${Strings.lastUpdate} ${_lastUpdateSpendingAll?.toDateTime()}",
                            style: TextStyles.textHint.copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: Dimens.fontSmall),
                          ),
                          Text(Strings.totalSpendingAll),
                          Text(
                            _totalSpendingAll.toString().toIDR(),
                            style: TextStyles.textBold.copyWith(
                                fontSize: Dimens.fontLarge1,
                                color: Palette.red),
                          )
                        ],
                      ),
                    ),
                    onTap: () {})
                : _searchType == SearchType.Month
                    ? CardView(
                        margin: EdgeInsets.symmetric(vertical: context.dp16()),
                        child: Container(
                          padding: EdgeInsets.all(context.dp16()),
                          color: Palette.blueSoft,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateTime.now().toString().toMonthYearText(),
                                  style: TextStyles.textBold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _totalCurMonth.toString().toIDR(),
                                    style: TextStyles.textBold
                                        .copyWith(fontSize: Dimens.fontLarge2),
                                  ),
                                  Icon(
                                    _totalCurMonth <= 0
                                        ? Icons.trending_down_rounded
                                        : Icons.trending_up_rounded,
                                    color: _totalCurMonth <= 0
                                        ? Palette.red
                                        : Palette.green,
                                    size: context.dp30(),
                                  )
                                ],
                              ),
                              Divider(),
                              Text(
                                "${Strings.lastUpdate} ${_lastUpdateIncomingCurMonth?.toDateTime()}",
                                style: TextStyles.textHint.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.fontSmall),
                              ),
                              Text(Strings.totalIncomeCurMonthDot),
                              Text(
                                _totalIncomingCurMonth.toString().toIDR(),
                                style: TextStyles.textBold.copyWith(
                                    fontSize: Dimens.fontLarge1,
                                    color: Palette.green),
                              ),
                              Divider(),
                              Text(
                                "${Strings.lastUpdate} ${_lastUpdateSpendingCurMonth?.toDateTime()}",
                                style: TextStyles.textHint.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.fontSmall),
                              ),
                              Text(Strings.totalSpendingCurMonthDot),
                              Text(
                                _totalSpendingCurMonth.toString().toIDR(),
                                style: TextStyles.textBold.copyWith(
                                    fontSize: Dimens.fontLarge1,
                                    color: Palette.red),
                              )
                            ],
                          ),
                        ),
                        onTap: () {})
                    : CardView(
                        margin: EdgeInsets.symmetric(vertical: context.dp16()),
                        child: Container(
                          padding: EdgeInsets.all(context.dp16()),
                          color: Palette.colorHintSoft,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month - 1,
                                          DateTime.now().day)
                                      .toString()
                                      .toMonthYearText(),
                                  style: TextStyles.textBold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _totalLastMonth.toString().toIDR(),
                                    style: TextStyles.textBold
                                        .copyWith(fontSize: Dimens.fontLarge2),
                                  ),
                                  Icon(
                                    _totalLastMonth <= 0
                                        ? Icons.trending_down_rounded
                                        : Icons.trending_up_rounded,
                                    color: _totalLastMonth <= 0
                                        ? Palette.red
                                        : Palette.green,
                                    size: context.dp30(),
                                  )
                                ],
                              ),
                              Divider(),
                              Text(
                                "${Strings.lastUpdate} ${_lastUpdateIncomingLastMonth?.toDateTime()}",
                                style: TextStyles.textHint.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.fontSmall),
                              ),
                              Text(Strings.totalIncomeLastMonthDot),
                              Text(
                                _totalIncomingLastMonth.toString().toIDR(),
                                style: TextStyles.textBold.copyWith(
                                    fontSize: Dimens.fontLarge1,
                                    color: Palette.green),
                              ),
                              Divider(),
                              Text(
                                "${Strings.lastUpdate} ${_lastUpdateSpendingLastMonth?.toDateTime()}",
                                style: TextStyles.textHint.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.fontSmall),
                              ),
                              Text(Strings.totalSpendingLastMonthDot),
                              Text(
                                _totalSpendingLastMonth.toString().toIDR(),
                                style: TextStyles.textBold.copyWith(
                                    fontSize: Dimens.fontLarge1,
                                    color: Palette.red),
                              )
                            ],
                          ),
                        ),
                        onTap: () {}),
          ],
        ),
      ),
    );
  }
}
