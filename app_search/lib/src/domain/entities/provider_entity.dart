import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  final String name;

  const ProviderEntity({
    required this.name
  });

  @override
  List<Object?> get props => [name];
}