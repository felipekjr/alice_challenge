import 'package:app_search/app_search.dart';
import 'package:common_design_system/common_design_system.dart';
import 'package:core/base_app.dart';
import 'package:core/micro_app.dart';
import 'package:core/micro_core_utils.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AliceSearch());
}

class AliceSearch extends StatelessWidget with BaseApp {

  AliceSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.registerRoutes();

    return MaterialApp(
      title: 'Alice Search',
      theme: appTheme(),
      navigatorKey: navigatorKey,
      onGenerateRoute: super.generateRoute,
      initialRoute: '/search/home',
    );
  }

  @override
  Map<String, WidgetBuilderArgs> get baseRoutes => {};

  @override
  List<MicroApp> get microApps => [
    MicroAppSearchResolver()
  ];
}