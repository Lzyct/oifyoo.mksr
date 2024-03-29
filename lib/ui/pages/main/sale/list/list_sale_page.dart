import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/core/enums/payment_state.dart';
import 'package:oifyoo_mksr/ui/pages/main/sale/sale.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class ListSalePage extends StatefulWidget {
  ListSalePage({Key? key}) : super(key: key);

  @override
  _ListSalePageState createState() => _ListSalePageState();
}

class _ListSalePageState extends State<ListSalePage> {
  late ListSaleBloc _listSaleBloc;
  late DeleteSaleBloc _deleteSaleBloc;

  Map<String, Map<String, List<TransactionEntity>>>? _listSale;
  String _productName = "";
  SearchType _searchType = SearchType.All;
  PaymentState _paymentState = PaymentState.All;

  var _listLabelTab = [
    DataSelected(title: Strings.all, isSelected: true),
    DataSelected(title: Strings.thisMonth, isSelected: false),
    DataSelected(title: Strings.today, isSelected: false),
  ];

  var _paymentStateLabel = [
    Strings.all,
    Strings.paidOff,
    Strings.notYetPaidOff
  ];

  var _selectedPaymentState = Strings.all;

  @override
  void initState() {
    super.initState();
    _listSaleBloc = BlocProvider.of(context);
    _deleteSaleBloc = BlocProvider.of(context);
    _getListSale();
  }

  @override
  void dispose() {
    super.dispose();
    _listSaleBloc.close();
    _deleteSaleBloc.close();
  }

  _getListSale() async {
    _listSaleBloc.listSale(
        searchText: _productName,
        type: _searchType,
        paymentState: _paymentState);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: null,
      isScroll: false,
      isPadding: false,
      floatingButton: FloatingActionButton(
          backgroundColor: Palette.colorPrimary,
          onPressed: () async {
            await context.goTo(
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => AddSaleBloc()),
                  BlocProvider(create: (_) => TransactionNumberSaleBloc()),
                  BlocProvider(create: (_) => ListProductBloc()),
                ],
                child: AddSalePage(),
              ),
            );
            _getListSale();
          },
          tooltip: Strings.addMedicalRecord,
          child: Icon(Icons.add)),
      child: Column(
        children: [
          AnimatedSearchBar(
            label: Strings.searchSale,
            labelStyle: TextStyles.textBold,
            searchStyle: TextStyles.text,
            searchDecoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: Strings.searchSaleHint,
                hintStyle: TextStyles.textHint,
                contentPadding: EdgeInsets.symmetric(horizontal: context.dp8()),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(context.dp4()),
                  borderSide: BorderSide(
                    color: Palette.colorPrimary,
                    width: 1.0,
                  ),
                )),
            cursorColor: Palette.colorPrimary,
            onChanged: (value) {
              _productName = value;
              _getListSale();
            },
          ).margin(
              edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16())),
          CustomTab(
            listData: _listLabelTab,
            selected: (index) {
              switch (index) {
                case 0:
                  _searchType = SearchType.All;
                  break;
                case 1:
                  _searchType = SearchType.Month;
                  break;
                case 2:
                  _searchType = SearchType.Day;
                  break;
              }
              _getListSale();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.paymentStatus),
              Container(
                margin: EdgeInsets.all(context.dp16()),
                width: context.widthInPercent(40),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: context.dp16()),
                      border: OutlineInputBorder(gapPadding: 0)),
                  items: _paymentStateLabel
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  value: _selectedPaymentState,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentState = value.toString();
                      switch (value) {
                        case Strings.all:
                          _paymentState = PaymentState.All;
                          break;
                        case Strings.paidOff:
                          _paymentState = PaymentState.Lunas;
                          break;
                        case Strings.notYetPaidOff:
                          _paymentState = PaymentState.BelumLunas;
                          break;
                      }
                      logs("SelectedPayment onChanged $value");
                      _getListSale();
                    });
                  },
                ),
              ),
            ],
          ),
          Expanded(
              child: BlocListener(
            bloc: _deleteSaleBloc,
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
                    Strings.successVoidData.toToastSuccess();
                    _getListSale();
                  }
                  break;
              }
            },
            child: BlocBuilder(
              bloc: _listSaleBloc,
              builder: (_, dynamic state) {
                switch (state.status) {
                  case Status.LOADING:
                    {
                      return Center(child: Loading());
                    }
                  case Status.EMPTY:
                    {
                      return Center(
                        child: Empty(
                          errorMessage: state.message.toString(),
                        ),
                      );
                    }
                  case Status.ERROR:
                    {
                      return Center(
                        child: Empty(
                          errorMessage: state.message.toString(),
                        ),
                      );
                    }
                  case Status.SUCCESS:
                    {
                      _listSale = state.data;
                      logs("_listSale length ${_listSale!.length}");
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getListSale();
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _listSale!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              // create nested listView
                              // first list is for generate date label
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == _listSale!.length - 1
                                        ? kToolbarHeight + context.dp16()
                                        : 0),
                                child: _listHeader(
                                    _listSale!.keys.elementAt(index),
                                    _listSale!.values.elementAt(index)),
                              );
                              // return _listItem(index);
                            }),
                      );
                    }
                  default:
                    return Container();
                }
              },
            ),
          )),
        ],
      ),
    );
  }

  Widget _listHeader(
    String date,
    Map<String, List<TransactionEntity>> totalPerDay,
  ) {
    List<TransactionEntity> _listTransactionEntity =
        totalPerDay.values.elementAt(0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Palette.colorBackgroundAlt,
          padding: EdgeInsets.all(context.dp16()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyles.textBold,
              ),
              Text(
                "${Strings.totalDot} ${totalPerDay.keys.elementAt(0).toIDR()}",
                style: TextStyles.primaryBold.copyWith(color: Palette.green),
              )
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listTransactionEntity.length,
            itemBuilder: (_, index) {
              return _listItem(_listTransactionEntity[index]);
            }),
      ],
    );
  }

  _listItem(TransactionEntity transactionEntity) {
    var _total = (transactionEntity.total! - transactionEntity.discount!)
        .toString()
        .toIDR();
    return Dismissible(
      key: UniqueKey(),
      background: Delete(),
      secondaryBackground: Edit(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(
                  Strings.delete,
                  style: TextStyles.textBold,
                ),
                content: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: Strings.askDelete,
                      style: TextStyles.text,
                    ),
                    TextSpan(
                        text: " ${transactionEntity.transactionNumber} ",
                        style: TextStyles.textBold),
                    TextSpan(
                      text: Strings.questionMark,
                      style: TextStyles.text,
                    )
                  ]),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      Strings.cancel,
                      style: TextStyles.textHint,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          dialogContext, false); // Dismiss alert dialog
                    },
                  ),
                  TextButton(
                    child: Text(
                      Strings.delete,
                      style: TextStyles.text.copyWith(color: Palette.red),
                    ),
                    onPressed: () {
                      _deleteSaleBloc
                          .deleteSale(transactionEntity.transactionNumber);
                      Navigator.pop(
                          dialogContext, true); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          await context.goTo(MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EditSaleBloc()),
                BlocProvider(create: (_) => DetailSaleBloc()),
              ],
              child: EditSalePage(
                  transactionNumber: transactionEntity.transactionNumber,
                  total: transactionEntity.total.toString().toIDR(),
                  discount: transactionEntity.discount.toString().toIDR())));
          _getListSale();
        }
        return false;
      },
      child: CardView(
          margin: EdgeInsets.symmetric(
              vertical: context.dp8(), horizontal: context.dp16()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextD(
                isFirst: true,
                hint: Strings.transactionNumber,
                content: transactionEntity.transactionNumber,
              ),
              SizedBox(height: context.dp8()),
              Text(
                transactionEntity.buyer!,
                style: TextStyles.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _total,
                    style: TextStyles.text,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: transactionEntity.status == Strings.listStatus[0]
                          ? Palette.red
                          : Palette.green,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.radius)),
                    ),
                    padding: EdgeInsets.all(context.dp8()),
                    child: Text(
                      transactionEntity.status!,
                      style: TextStyles.white,
                    ),
                  ),
                ],
              )
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(BlocProvider(
              create: (_) => DetailSaleBloc(),
              child: DetailSalePage(
                transactionNumber: transactionEntity.transactionNumber,
                total: transactionEntity.total.toString().toIDR(),
                discount: transactionEntity.discount.toString().toIDR(),
              ),
            ));
          }),
    );
  }
}
