import '../../domain/entities/entities.dart';

class LocalProviderModel {
  final String name;

  LocalProviderModel({
    required this.name
  });

  factory LocalProviderModel.fromJson(Map json) {
    return LocalProviderModel(name: json['name']);
  }

  ProviderEntity toEntity() => ProviderEntity(name: name);
}