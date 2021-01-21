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
class ListPurchasePage extends StatefulWidget {
  ListPurchasePage({Key key}) : super(key: key);

  @override
  _ListPurchasePageState createState() => _ListPurchasePageState();
}

class _ListPurchasePageState extends State<ListPurchasePage> {
  ListPurchaseBloc _listPurchaseBloc;
  DeletePurchaseBloc _deletePurchaseBloc;

  List<TransactionEntity> _listPurchase;
  String _productName = "";

  @override
  void initState() {
    super.initState();
    _listPurchaseBloc = BlocProvider.of(context);
    _deletePurchaseBloc = BlocProvider.of(context);
    _getListPurchase();
  }

  _getListPurchase() async {
    _listPurchaseBloc.listPurchase(_productName);
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
                  BlocProvider(create: (_) => AddPurchaseBloc()),
                  BlocProvider(create: (_) => TransactionNumberPurchaseBloc()),
                  BlocProvider(create: (_) => ListProductBloc()),
                ],
                child: AddPurchasePage(),
              ),
            );
            _getListPurchase();
          },
          tooltip: Strings.addMedicalRecord,
          child: Icon(Icons.add)),
      child: Column(
        children: [
          AnimatedSearchBar(
            label: Strings.searchPurchase,
            labelStyle: TextStyles.textBold,
            searchStyle: TextStyles.text,
            searchDecoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: Strings.searchPurchaseHint,
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
              _listPurchaseBloc.listPurchase(_productName);
            },
          ).margin(
              edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16())),
          Expanded(
              child: BlocListener(
            cubit: _deletePurchaseBloc,
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
                    _getListPurchase();
                  }
                  break;
              }
            },
            child: BlocBuilder(
              cubit: _listPurchaseBloc,
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
                      _listPurchase = state.data;
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getListPurchase();
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _listPurchase.length,
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
                        text: " ${_listPurchase[index].transactionNumber} ",
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
                      _deletePurchaseBloc.deletePurchase(
                          _listPurchase[index].transactionNumber);

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
                BlocProvider(create: (_) => EditPurchaseBloc()),
                BlocProvider(create: (_) => DetailPurchaseBloc()),
              ],
              child: EditPurchasePage(
                transactionNumber: _listPurchase[index].transactionNumber,
                total: _listPurchase[index].total.toString().toIDR(),
              )));
          _getListPurchase();
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
                content: _listPurchase[index].transactionNumber,
              ),
              SizedBox(height: context.dp8()),
              Text(
                _listPurchase[index].buyer,
                style: TextStyles.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_listPurchase[index].total.toString().toIDR()}",
                    style: TextStyles.text,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          _listPurchase[index].status == Strings.listStatus[0]
                              ? Palette.red
                              : Palette.green,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.radius)),
                    ),
                    padding: EdgeInsets.all(context.dp8()),
                    child: Text(
                      _listPurchase[index].status,
                      style: TextStyles.white,
                    ),
                  ),
                ],
              )
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(BlocProvider(
              create: (_) => DetailPurchaseBloc(),
              child: DetailPurchasePage(
                transactionNumber: _listPurchase[index].transactionNumber,
                total: _listPurchase[index].total.toString().toIDR(),
              ),
            ));
          }),
    );
  }
}
