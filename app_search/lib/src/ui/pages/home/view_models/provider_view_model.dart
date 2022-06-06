import 'package:equatable/equatable.dart';

class ProviderViewModel extends Equatable {
  final String name;
  final bool isVisible;
  final int index;

  const ProviderViewModel({
    required this.name,
    required this.isVisible,
    required this.index
  });

  ProviderViewModel copy({
    bool? isVisible
  }) => ProviderViewModel(
    isVisible: isVisible ?? this.isVisible,
    name: name,
    index: index
  );

  @override
  List<Object?> get props => [name, isVisible, index];
}