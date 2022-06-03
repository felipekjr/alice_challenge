
import 'package:core/micro_app.dart';
import 'package:core/micro_core_utils.dart';

import 'ui/pages/pages.dart';

class MicroAppSearchResolver implements MicroApp {
  @override
  String get name => 'search';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
    '/$name/home': (context, args) => const HomePage()
  };

}