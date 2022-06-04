
import 'package:app_search/src/data/usecases/local_get_providers.dart';
import 'package:app_search/src/presentation/value_notifier_home_presenter.dart';
import 'package:core/micro_app.dart';
import 'package:core/micro_core_utils.dart';
import 'package:flutter/services.dart';

import 'ui/pages/pages.dart';

class MicroAppSearchResolver implements MicroApp {
  @override
  String get name => 'search';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
    '/$name/home': (context, args) => HomePage(
      presenter: ValueNotifierHomePresenter(getProviders: LocalGetProviders(assetsDataSource: rootBundle))
    )
  };

}