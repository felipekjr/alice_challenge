import 'package:app_search/src/data/usecases/usecases.dart';
import 'package:app_search/src/domain/usecases/usecases.dart';
import 'package:flutter/services.dart';

GetProviders makeGetProviders() => LocalGetProviders(
  assetsDataSource: rootBundle
);