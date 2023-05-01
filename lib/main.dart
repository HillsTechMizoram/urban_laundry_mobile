//region imports
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:urban_laundry_mobile/screens/LSOnBoardingScreen.dart';
import 'package:urban_laundry_mobile/screens/LSWalkThroughScreen.dart';
import 'package:urban_laundry_mobile/store/AppStore.dart';
import 'package:urban_laundry_mobile/utils/AppTheme.dart';
import 'package:urban_laundry_mobile/utils/LSContstants.dart';
import 'package:urban_laundry_mobile/utils/LSWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();

int currentIndex = 0;

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(MyApp());
  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic token = SessionManager().get('token');
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '$appName${!isMobile ? ' ${platformName()}' : ''}',
        home: token != '' ? LSWalkThroughScreen() : LSOnBoardingScreen(),
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
