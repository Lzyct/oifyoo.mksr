import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
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
class ListSpendingPage extends StatefulWidget {
  ListSpendingPage({Key key}) : super(key: key);

  @override
  _ListSpendingPageState createState() => _ListSpendingPageState();
}

class _ListSpendingPageState extends State<ListSpendingPage> {
  ListSpendingBloc _listSpendingBloc;
  DeleteSpendingBloc _deleteSpendingBloc;

  List<SpendingEntity> _listSpending;
  String _spendingName = "";

  @override
  void initState() {
    super.initState();
    _listSpendingBloc = BlocProvider.of(context);
    _deleteSpendingBloc = BlocProvider.of(context);
    _getListSpending();
  }

  _getListSpending() {
    _listSpendingBloc.listSpending(_spendingName);
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
            await context.goTo(BlocProvider(
              create: (_) => AddSpendingBloc(),
              child: AddSpendingPage(),
            ));
            _getListSpending();
          },
          tooltip: Strings.addMedicalRecord,
          child: Icon(Icons.add)),
      child: Column(
        children: [
          AnimatedSearchBar(
            label: Strings.searchSpending,
            labelStyle: TextStyles.textBold,
            searchStyle: TextStyles.text,
            searchDecoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: Strings.searchSpendingHint,
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
              _spendingName = value;
              _listSpendingBloc.listSpending(_spendingName);
            },
          ).margin(
              edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16())),
          Expanded(
              child: BlocListener(
            cubit: _deleteSpendingBloc,
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
                    _getListSpending();
                  }
                  break;
              }
            },
            child: BlocBuilder(
              cubit: _listSpendingBloc,
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
                      _listSpending = state.data;
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getListSpending();
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _listSpending.length,
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
                        text: " ${_listSpending[index].name} ",
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
                      _deleteSpendingBloc
                          .deleteSpending(_listSpending[index].id);
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
                BlocProvider(create: (_) => EditSpendingBloc()),
                BlocProvider(create: (_) => DetailSpendingBloc()),
              ],
              child: EditSpendingPage(
                id: _listSpending[index].id,
              )));
          _getListSpending();
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
                      _listSpending[index].name,
                      style: TextStyles.textBold
                          .copyWith(fontSize: Dimens.fontLarge),
                    ),
                  ),
                  Text(
                    _listSpending[index].price.toString().toIDR(),
                    style: TextStyles.textBold,
                  )
                ],
              ),
              SizedBox(height: context.dp8()),
              Text(
                _listSpending[index].updatedAt.toString().toDateTime(),
                style: TextStyles.text.copyWith(fontSize: Dimens.fontSmall),
              ),
              SizedBox(height: context.dp8()),
              Text(
                "${Strings.note} : ${_listSpending[index].note}",
                style: TextStyles.textHint.copyWith(
                    fontStyle: FontStyle.italic, fontSize: Dimens.fontSmall),
              ),
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(BlocProvider(
              create: (_) => DetailSpendingBloc(),
              child: DetailSpendingPage(
                id: _listSpending[index].id,
              ),
            ));
          }),
    );
  }
}
