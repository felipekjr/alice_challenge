import 'package:app_search/src/ui/pages/home/home.dart';

import 'ui_state.dart';

class ProvidersLoadedState extends UIState {
  final List<VisibleProviderEntity> list;

  const ProvidersLoadedState(this.list) : super();

  @override
  List<Object> get props => [list];
}

class ProvidersFilteredState extends UIState {
  final List<VisibleProviderEntity> list;

  const ProvidersFilteredState(this.list) : super();

  @override
  List<Object> get props => [list];
}