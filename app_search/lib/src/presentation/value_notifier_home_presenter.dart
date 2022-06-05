import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:app_search/src/presentation/helpers/home_state.dart';
import 'package:app_search/src/presentation/helpers/ui_state.dart';
import 'package:app_search/src/ui/pages/pages.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

class ValueNotifierHomePresenter implements HomePresenter {
  final GetProviders getProviders;

  ValueNotifierHomePresenter({
    required this.getProviders
  }); 

  @override
  ValueNotifier<List<VisibleProviderEntity>?> filteredProvidersNotifier = ValueNotifier(null);

  @override
  List<ProviderEntity> providers = [];

  @override
  ValueNotifier<UIState> stateNotifier = ValueNotifier(const UIInitialState());

  List<VisibleProviderEntity>? get filteredProviders => filteredProvidersNotifier.value;

  @override
  void dispose() {
    filteredProvidersNotifier.dispose();
    stateNotifier.dispose();
  }

  @override
  Future<void>? getAll() async {
    try {
      stateNotifier.value = const UILoadingState();
      await Future.delayed(const Duration(seconds: 2));
      providers = await getProviders();
      filteredProvidersNotifier.value = _makeVisibleProviders(providers);
      stateNotifier.value = ProvidersLoadedState(filteredProviders ?? []);
    } catch (_) {
      stateNotifier.value = const UIErrorState('Erro ao recuperar colaboradores');
    }
  }

  _makeVisibleProviders(List<ProviderEntity> providerEntities) {
    return providerEntities.mapIndexed((e, index) => VisibleProviderEntity(
      name: e.name, 
      isVisible: true,
      index: index
    )).toList();
  }

  @override
  void filterProviders(String text) {
    final filteredItens =  providers
      .where((p) => p.name.startsWith(text))
      .toList();

    filteredProvidersNotifier.value = filteredProviders?.map((e) => e.copy(
      isVisible: filteredItens.any((f) => f.name == e.name)
    )).toList();

    stateNotifier.value = ProvidersFilteredState(filteredProviders ?? []);
  }
}