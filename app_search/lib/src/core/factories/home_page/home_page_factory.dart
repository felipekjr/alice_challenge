import 'package:app_search/src/core/factories/home_page/home_page.dart';
import 'package:app_search/src/ui/pages/home/home.dart';

HomePage makeHomePage() => HomePage(
  presenter: makeHomePresenter()
);