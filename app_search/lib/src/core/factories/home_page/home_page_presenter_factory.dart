import 'package:app_search/src/core/factories/usecases/usecases.dart';
import 'package:app_search/src/presentation/presentation.dart';
import 'package:app_search/src/ui/pages/home/home.dart';

HomePresenter makeHomePresenter() => ValueNotifierHomePresenter(
  getProviders: makeGetProviders()
);