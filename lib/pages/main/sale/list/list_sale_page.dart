import 'dart:io';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/pages/main/main.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/12/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class ListSalePage extends StatefulWidget {
  ListSalePage({Key key}) : super(key: key);

  @override
  _ListSalePageState createState() => _ListSalePageState();
}

class _ListSalePageState extends State<ListSalePage> {
  ListSaleBloc _listSaleBloc;
  DeleteSaleBloc _deleteSaleBloc;

  List<TransactionEntity> _listSale;
  String _productName = "";

  @override
  void initState() {
    super.initState();
    _listSaleBloc = BlocProvider.of(context);
    _deleteSaleBloc = BlocProvider.of(context);
    _getListSale();
  }

  _getListSale() async {
    _listSaleBloc.listSale(_productName);
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    logs("path $documentsDirectory");
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
              _listSaleBloc.listSale(_productName);
            },
          ).margin(
              edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16())),
          Expanded(
              child: BlocListener(
            cubit: _deleteSaleBloc,
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
                    Strings.successVoidData.toToastSuccess();
                    _getListSale();
                  }
                  break;
              }
            },
            child: BlocBuilder(
              cubit: _listSaleBloc,
              builder: (_, state) {
                switch (state.status) {
                  case Status.LOADING:
                    {
                      return Center(child: Loading());
                    }
                    break;
                  case Status.EMPTY:
                    {
                      return Center(
                        child: Empty(
                          errorMessage: state.message.toString(),
                        ),
                      );
                    }
                    break;
                  case Status.ERROR:
                    {
                      return Center(
                        child: Empty(
                          errorMessage: state.message.toString(),
                        ),
                      );
                    }
                    break;
                  case Status.SUCCESS:
                    {
                      _listSale = state.data;
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getListSale();
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _listSale.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return _listItem(index);
                            }),
                      );
                    }
                    break;
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

  _listItem(int index) {
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
                        text: " ${_listSale[index].transactionNumber} ",
                        style: TextStyles.textBold),
                    TextSpan(
                      text: Strings.questionMark,
                      style: TextStyles.text,
                    )
                  ]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      Strings.cancel,
                      style: TextStyles.textHint,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          dialogContext, false); // Dismiss alert dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      Strings.delete,
                      style: TextStyles.text.copyWith(color: Palette.red),
                    ),
                    onPressed: () {
                      _deleteSaleBloc
                          .deleteSale(_listSale[index].transactionNumber);

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
                transactionNumber: _listSale[index].transactionNumber,
                total: _listSale[index].total.toString().toIDR(),
              )));
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
                content: _listSale[index].transactionNumber,
              ),
              SizedBox(height: context.dp8()),
              Text(
                _listSale[index].buyer,
                style: TextStyles.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_listSale[index].total.toString().toIDR()}",
                    style: TextStyles.text,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _listSale[index].status == Strings.listStatus[0]
                          ? Palette.red
                          : Palette.green,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.radius)),
                    ),
                    padding: EdgeInsets.all(context.dp8()),
                    child: Text(
                      _listSale[index].status,
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
                transactionNumber: _listSale[index].transactionNumber,
                total: _listSale[index].total.toString().toIDR(),
              ),
            ));
          }),
    );
  }
}
