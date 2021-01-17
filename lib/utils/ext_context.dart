import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/resources/resources.dart';

extension ContextExtensions on BuildContext {
  bool isMobile() {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide < 600;
  }

  logs(dynamic message) {
    print(
        "========================================================================================");
    print("| Message Log : $message");
    print("| Widget Name : ${this.widget}");
    print(
        "========================================================================================");
  }

  goTo(Widget widget) async {
    await Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  goToReplacePageRoute(Widget widget) async {
    await Navigator.pushReplacement(
        this,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (_, __, ___) => widget));
  }

  goToReplace(Widget widget) async {
    await Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  goToClearStack(Widget widget) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  appBar({@required String title}) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Palette.colorPrimary,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Palette.colorText,
        ),
        onPressed: () {
          Navigator.pop(this);
        },
      ),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyles.text.copyWith(
          fontSize: Dimens.fontLarge,
        ),
      ),
    );
  }

  noAppBarDark() => PreferredSize(
      child: AppBar(
          backgroundColor: Palette.colorPrimary,
          elevation: 0.0,
          brightness: Brightness.dark),
      preferredSize: Size.fromHeight(0.0));

  noAppBarLight() => PreferredSize(
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light),
      preferredSize: Size.fromHeight(0.0));

  Future<DateTime> datePicker() async {
    return await showDatePicker(
      context: this,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 100),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      helpText: Strings.selectDate,
      confirmText: Strings.select,
      cancelText: Strings.cancel,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.colorPrimary,
            hintColor: Palette.colorPrimary,
            accentColor: Palette.colorPrimary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(
              primary: Palette.colorPrimary,
              onError: Palette.red,
              onPrimary: Colors.white,
              surface: Palette.colorPrimary,
              secondary: Colors.white,
              onSurface: Palette.colorPrimary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
  }

  Future<String> timePicker() async {
    var result = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: this,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: Strings.selectTime,
      confirmText: Strings.select,
      cancelText: Strings.cancel,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.colorPrimary,
            hintColor: Palette.colorPrimary,
            accentColor: Palette.colorPrimary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(
              primary: Palette.colorPrimary,
              onError: Palette.red,
              onPrimary: Colors.white,
              surface: Colors.white,
              secondary: Palette.colorPrimary,
              onSurface: Palette.colorPrimary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );

    //add 0 if length =1
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(result.hour)}:${result.minute}";
  }

  bottomSheet({@required String title, @required Widget child, double height}) {
    showModalBottomSheet(
        context: this,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(dp16()),
          topRight: Radius.circular(dp16()),
        )),
        backgroundColor: Colors.white,
        elevation: dp16(),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: dp16(), horizontal: dp24()),
            height: height ?? heightInPercent(80),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(dp16()),
              topRight: Radius.circular(dp16()),
            )),
            child: Column(
              children: [
                Container(
                  width: Dimens.bottomButton,
                  height: Dimens.radius,
                  margin: EdgeInsets.only(bottom: dp16()),
                  decoration: BoxDecoration(
                      color: Palette.bottomIndicator,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                Text(
                  title,
                  style: TextStyles.text.copyWith(
                      fontSize: Dimens.fontLarge2, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: dp16()),
                Expanded(
                  child: child,
                )
              ],
            ),
          );
        });
  }

  /// Dimens should define in context extensions
  ///

  widthInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.width * toDouble;
  }

  heightInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.height * toDouble;
  }

  dp2() {
    return MediaQuery.of(this).size.width / 120;
  }

  dp4() {
    return MediaQuery.of(this).size.width / 100;
  }

  dp6() {
    return MediaQuery.of(this).size.width / 70;
  }

  dp8() {
    return MediaQuery.of(this).size.width / 54;
  }

  dp10() {
    return MediaQuery.of(this).size.width / 41;
  }

  dp12() {
    return MediaQuery.of(this).size.width / 34;
  }

  dp14() {
    return MediaQuery.of(this).size.width / 29;
  }

  dp16() {
    return MediaQuery.of(this).size.width / 26;
  }

  dp18() {
    return MediaQuery.of(this).size.width / 23;
  }

  dp20() {
    return MediaQuery.of(this).size.width / 20;
  }

  dp22() {
    return MediaQuery.of(this).size.width / 17;
  }

  dp24() {
    return MediaQuery.of(this).size.width / 16;
  }

  dp25() {
    return MediaQuery.of(this).size.width / 15;
  }

  dp28() {
    return MediaQuery.of(this).size.width / 12;
  }

  dp30() {
    return MediaQuery.of(this).size.width / 10;
  }

  dp32() {
    return MediaQuery.of(this).size.width / 8;
  }

  dp36() {
    return MediaQuery.of(this).size.width / 6;
  }

  logout() {
    //clear shared Preferences
    sl<PrefManager>().logout();
    /*this.goToReplacePageRoute(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: LoginPage(),
    ));*/
  }
}
