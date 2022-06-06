import '../ui_state.dart';
import '../../ui/pages/home/view_models/provider_view_model.dart';

class ProvidersLoadedState extends UIState {
  final List<ProviderViewModel> list;

  const ProvidersLoadedState(this.list) : super();

  @override
  List<Object> get props => [list];
}

class ProvidersFilteredState extends UIState {
  final List<ProviderViewModel> list;

  const ProvidersFilteredState(this.list) : super();

  @override
  List<Object> get props => [list];
}