import 'package:flutter/foundation.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../presentation/ui_state.dart';
import 'view_models/view_models.dart';

abstract class HomePresenter {
  List<ProviderEntity> providers = [];
  late ValueNotifier<List<ProviderViewModel>> filteredProvidersNotifier;
  late ValueNotifier<UIState> stateNotifier;

  void getAll();
  void filterProviders(String text);
  void dispose();
}