import '../../domain/entities/entities.dart';

class LocalProviderModel {
  final String name;
  final String type;
  final String site;

  LocalProviderModel({
    required this.name,
    required this.type,
    required this.site
  });

  factory LocalProviderModel.fromJson(Map json) {
    return LocalProviderModel(
      name: json['name'],
      type: json['type'],
      site: json['site']
    );
  }

  ProviderEntity toEntity() => ProviderEntity(name: name);
}