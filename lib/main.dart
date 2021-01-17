import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/pages/splashscreen/splash_screen_page.dart';
import 'package:oifyoo_mksr/resources/resources.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  serviceLocator();

/*  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;*/

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: Size(375, 667),
        allowFontScaling: false,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('id'),
          ],
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: 1, alwaysUse24HourFormat: true),
              child: child,
            );
          },
          title: Strings.appName,
          theme: themeDefault,
          home: SplashScreenPage(),
        ),
      ),
    );
  }
}
