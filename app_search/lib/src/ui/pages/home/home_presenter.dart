import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/presentation/helpers/ui_state.dart';
import 'package:flutter/material.dart';

import '../pages.dart';

abstract class HomePresenter {
  List<ProviderEntity> providers = [];
  late ValueNotifier<List<VisibleProviderEntity>?> filteredProvidersNotifier;
  late ValueNotifier<UIState> stateNotifier;

  void getAll();
  void filterProviders(String text);
  void dispose();
}