import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:app_search/src/presentation/helpers/ui_state.dart';
import 'package:app_search/src/ui/pages/pages.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class ValueNotifierHomePresenter implements HomePresenter {
  final GetProviders getProviders;

  ValueNotifierHomePresenter({
    required this.getProviders
  }); 

  @override
  ValueNotifier<List<ProviderEntity>?> filteredProvidersNotifier = ValueNotifier(null);

  @override
  List<ProviderEntity> providers = [];

  @override
  ValueNotifier<UIState> stateNotifier = ValueNotifier(const UIInitialState());

  @override
  void dispose() {
    filteredProvidersNotifier.dispose();
    stateNotifier.dispose();
  }

  @override
  Future<void>? getAll() async {
    try {
      stateNotifier.value = const UILoadingState();
      providers = await getProviders();
      filteredProvidersNotifier.value = providers;
      stateNotifier.value = const UIInitialState();
    } catch (_) {
      stateNotifier.value = const UIErrorState('Erro ao recuperar colaboradores');
    }
  }

  @override
  void filterProviders(String text) {
    // TODO: implement filterProviders
  }
}