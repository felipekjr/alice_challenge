import 'package:flutter/foundation.dart';

import '../../core/extensions/extensions.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/usecases/get_providers.dart';
import '../../ui/pages/pages.dart';
import '../ui_state.dart';
import 'home_state.dart';

class ValueNotifierHomePresenter implements HomePresenter {
  final GetProviders getProviders;

  ValueNotifierHomePresenter({
    required this.getProviders
  }); 

  @override
  ValueNotifier<UIState> stateNotifier = ValueNotifier(const UIInitialState());
  @override
  List<ProviderEntity> providers = [];
  @override
  ValueNotifier<List<ProviderViewModel>> filteredProvidersNotifier = ValueNotifier([]);

  List<ProviderViewModel> get filteredProviders => filteredProvidersNotifier.value;

  @override
  Future<void>? getAll() async {
    try {
      stateNotifier.value = const UILoadingState();
      await Future.delayed(const Duration(seconds: 2));
      providers = await getProviders();
      filteredProvidersNotifier.value = _makeVisibleProviders(providers);
      stateNotifier.value = ProvidersLoadedState(filteredProviders);
    } catch (_) {
      stateNotifier.value = const UIErrorState('Erro ao recuperar colaboradores');
    }
  }

  @override
  void filterProviders(String text) {
    final filteredItens =  providers
      .where((p) => p.name.startsWith(text))
      .toList();

    filteredProvidersNotifier.value = filteredProviders.map((e) => e.copy(
      isVisible: filteredItens.any((f) => f.name == e.name)
    )).toList();

    stateNotifier.value = ProvidersFilteredState(filteredProviders);
  }

  _makeVisibleProviders(List<ProviderEntity> providerEntities) {
    return providerEntities.mapIndexed((e, index) => ProviderViewModel(
      name: e.name, 
      isVisible: true,
      index: index
    )).toList();
  }

  @override
  void dispose() {
    filteredProvidersNotifier.dispose();
    stateNotifier.dispose();
  }
}