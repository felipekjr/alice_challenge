import 'package:app_search/src/core/extensions/extensions.dart';
import 'package:app_search/src/domain/entities/entities.dart';
import 'package:app_search/src/ui/pages/home/home.dart';

makeVisibleProviders(List<ProviderEntity> providerEntities) {
  return providerEntities.mapIndexed((e, index) => ProviderViewModel(
    name: e.name, 
    isVisible: true,
    index: index
  )).toList();
}