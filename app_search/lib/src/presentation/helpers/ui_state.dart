import 'package:equatable/equatable.dart';

abstract class UIState extends Equatable {
  const UIState();
}

class UIInitialState extends UIState {
  const UIInitialState() : super();

  @override
  List<Object> get props => [];
}

class UILoadingState extends UIState {
  const UILoadingState() : super();

  @override
  List<Object> get props => [];
}

class UIErrorState extends UIState {
  final String description;

  const UIErrorState(this.description) : super();

  @override
  List<Object> get props => [description];
}

