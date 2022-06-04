import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class LocalGetProviders implements GetProviders {
  AssetBundle assetsDataSource;

  LocalGetProviders({
    required this.assetsDataSource
  });

  @override
  Future<List<ProviderEntity>> call() async {
    try {
      final jsonString = await assetsDataSource.loadString('assets/providers.json');
      final List data = await jsonDecode(jsonString);
      return data.map((e) => LocalProviderModel.fromJson(e).toEntity()).toList();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}