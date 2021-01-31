import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oifyoo_mksr/blocs/blocs.dart';
import 'package:oifyoo_mksr/data/models/models.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oifyoo_mksr/utils/utils.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DataSelected> _dataMenus = [];
  NavDrawerBloc _drawerBloc;
  String _currentOpen = Strings.home;

  @override
  void initState() {
    super.initState();
    _drawerBloc = BlocProvider.of<NavDrawerBloc>(context);
    _dataMenus = [
      DataSelected(title: Strings.home, isSelected: true),
      DataSelected(title: Strings.sale, isSelected: false),
      // DataSelected(title: Strings.purchase, isSelected: false),
      DataSelected(title: Strings.spending, isSelected: false),
      DataSelected(title: Strings.product, isSelected: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.logs("onBackPress");
          if (_currentOpen == Strings.home) {
            context.logs("true");
            return true;
          } else {
            context.logs("false");
            if (_scaffoldKey.currentState.isEndDrawerOpen) {
              //hide navigation drawer
              _scaffoldKey.currentState.openDrawer();
            } else {
              _drawerBloc.openDrawer(NavigationEvents.HomePage);

              _dataMenus.forEach((element) {
                setState(() {
                  if (element.title == Strings.home)
                    element.isSelected = true;
                  else
                    element.isSelected = false;
                });
              });
              _currentOpen = Strings.home;
            }
            return false;
          }
        },
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Palette.colorPrimary,
              centerTitle: true,
              title: Text(
                _currentOpen,
                style: TextStyles.primaryBold.copyWith(
                    fontSize: Dimens.fontLarge, color: Palette.colorText),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.sort,
                  color: Palette.colorText,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            body: BlocBuilder<NavDrawerBloc, Widget>(
              builder: (context, navigationState) {
                return navigationState;
              },
            ),
            drawer: _navDrawer()));
  }

  _navDrawer() {
    return SizedBox(
      width: context.widthInPercent(100),
      child: Drawer(
          child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Palette.colorPrimary,
            padding:
                EdgeInsets.only(top: context.dp20(), bottom: context.dp8()),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    Images.icLogo,
                    height: Dimens.height30,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FlatButton(
                    onPressed: () {
                      //hide navigation drawer
                      Navigator.pop(context);
                    },
                    shape: CircleBorder(),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Icon(
                      Icons.close,
                      color: Palette.colorText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Palette.colorText,
            width: double.infinity,
            height: context.dp4(),
          ),
          Column(
            children: _dataMenus
                .map<Widget>((value) => InkWell(
                      onTap: () {
                        _dataMenus.forEach((element) {
                          setState(() {
                            if (element.title == value.title)
                              element.isSelected = true;
                            else
                              element.isSelected = false;
                          });

                          //return selected page
                          switch (value.title) {
                            case Strings.home:
                              {
                                _drawerBloc
                                    .openDrawer(NavigationEvents.HomePage);
                                break;
                              }
                            case Strings.sale:
                              {
                                _drawerBloc
                                    .openDrawer(NavigationEvents.SalePage);
                              }
                              break;
                            // case Strings.purchase:
                            //   {
                            //     _drawerBloc
                            //         .openDrawer(NavigationEvents.PurchasePage);
                            //   }
                            //   break;
                            case Strings.spending:
                              {
                                _drawerBloc
                                    .openDrawer(NavigationEvents.SpendingPage);
                              }
                              break;
                            default:
                              {
                                _drawerBloc
                                    .openDrawer(NavigationEvents.Product);
                                break;
                              }
                          }

                          setState(() {
                            _currentOpen = value.title;
                          });

                          //hide navigation drawer
                          _scaffoldKey.currentState.openEndDrawer();
                        });
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Opacity(
                                opacity: value.isSelected ? 1 : 0,
                                child: Container(
                                  color: Palette.colorText,
                                  width: 4,
                                  height: context.dp30(),
                                ),
                              ),
                              SizedBox(
                                width: context.dp16(),
                              ),
                              Text(
                                value.title,
                                style: TextStyles.primaryBold.copyWith(
                                    fontSize: Dimens.fontLarge,
                                    color: Palette.colorText),
                              )
                            ],
                          ),
                        ],
                      ).padding(
                          edgeInsets:
                              EdgeInsets.symmetric(vertical: context.dp8())),
                    ))
                .toList(),
          ),
          SizedBox(
            height: context.dp30(),
          ),
          SizedBox(
            height: context.dp36(),
          ),
        ],
      )),
    );
  }
}
