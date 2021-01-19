import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/blocs/sale/delete_sale_bloc.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/pages/main/main.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:oifyoo_mksr/widgets/widgets.dart';

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

  _getListSale() {
    _listSaleBloc.listSale(_productName);
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
                      _getListSale();
                      Navigator.pop(
                          dialogContext, true); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          /*  await context.goTo(MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EditSaleBloc()),
                BlocProvider(create: (_) => DetailSaleBloc()),
              ],
              child: EditSalePage(
                trans: _listSale[index].id,
              )));*/
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _listSale[index].transactionNumber,
                      style: TextStyles.textBold
                          .copyWith(fontSize: Dimens.fontLarge1),
                    ),
                  ),
                  Text("${Strings.qtyDot} ${_listSale[index].qty}",
                      style: TextStyles.textBold)
                ],
              ),
              SizedBox(height: context.dp16()),
              Text(
                _listSale[index].productPrice.toString().toIDR(),
                style: TextStyles.text,
              ),
              SizedBox(height: context.dp8()),
              Text(
                "${Strings.lastUpdate} ${_listSale[index].updatedAt.toDateTime()}",
                style: TextStyles.textHint.copyWith(
                    fontStyle: FontStyle.italic, fontSize: Dimens.fontSmall),
              )
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            /* context.goTo(BlocProvider(
              create: (_) => DetailSaleBloc(),
              child: DetailSalePage(
                id: _listSale[index].id,
              ),
            ));*/
          }),
    );
  }
}
