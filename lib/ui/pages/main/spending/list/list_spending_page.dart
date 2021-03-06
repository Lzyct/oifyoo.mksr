import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/core/blocs/blocs.dart';
import 'package:oifyoo_mksr/core/data/models/models.dart';
import 'package:oifyoo_mksr/core/enums/enums.dart';
import 'package:oifyoo_mksr/ui/pages/main/main.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

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

  Map<String, Map<String, List<SpendingEntity>>> _listSpending;
  String _spendingName = "";

  SearchType _searchType = SearchType.All;

  var _listLabelTab = [
    DataSelected(title: Strings.all, isSelected: true),
    DataSelected(title: Strings.thisMonth, isSelected: false),
    DataSelected(title: Strings.today, isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _listSpendingBloc = BlocProvider.of(context);
    _deleteSpendingBloc = BlocProvider.of(context);
    _getListSpending();
  }

  _getListSpending() {
    _listSpendingBloc.listSpending(
        searchText: _spendingName, type: _searchType);
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
              _getListSpending();
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
              _getListSpending();
            },
          ),
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
                              // create nested listView
                              // first list is for generate date label
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == _listSpending.length - 1
                                        ? kToolbarHeight + context.dp16()
                                        : 0),
                                child: _listHeader(
                                    _listSpending.keys.elementAt(index),
                                    _listSpending.values.elementAt(index)),
                              );
                              // return _listItem(index);
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

  Widget _listHeader(
    String date,
    Map<String, List<SpendingEntity>> totalPerDay,
  ) {
    List<SpendingEntity> _listSpending = totalPerDay.values.elementAt(0);
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
            itemCount: _listSpending.length,
            itemBuilder: (_, index) {
              return _listItem(_listSpending[index]);
            }),
      ],
    );
  }

  _listItem(SpendingEntity spendingEntity) {
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
                        text: " ${spendingEntity.name} ",
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
                      _deleteSpendingBloc.deleteSpending(spendingEntity.id);
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
                id: spendingEntity.id,
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
                      spendingEntity.name,
                      style: TextStyles.textBold
                          .copyWith(fontSize: Dimens.fontLarge),
                    ),
                  ),
                  Text(
                    spendingEntity.price.toString().toIDR(),
                    style: TextStyles.textBold,
                  )
                ],
              ),
              SizedBox(height: context.dp8()),
              Text(
                spendingEntity.updatedAt.toString().toDateTime(),
                style: TextStyles.text.copyWith(fontSize: Dimens.fontSmall),
              ),
              SizedBox(height: context.dp8()),
              Text(
                "${Strings.note} : ${spendingEntity.note}",
                style: TextStyles.textHint.copyWith(
                    fontStyle: FontStyle.italic, fontSize: Dimens.fontSmall),
              ),
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(BlocProvider(
              create: (_) => DetailSpendingBloc(),
              child: DetailSpendingPage(
                id: spendingEntity.id,
              ),
            ));
          }),
    );
  }
}
