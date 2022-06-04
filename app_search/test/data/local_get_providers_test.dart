
import 'dart:convert';

import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

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

class PlatformAssetBundleSpy extends Mock implements PlatformAssetBundle {
  When mockCall() => when(() => loadString(any()));
  void mock(String response) => mockCall().thenAnswer((_) => Future.value(response));
}

class LocalGetProviders implements GetProviders {
  PlatformAssetBundle assetsDataSource;

  LocalGetProviders({
    required this.assetsDataSource
  });

  @override
  Future<List<ProviderEntity>> call() async {
    final jsonString = await assetsDataSource.loadString('assets/providers.json');
    final List data = await jsonDecode(jsonString);

    return data.map((e) => LocalProviderModel.fromJson(e).toEntity()).toList();
  }
}

void main() {
  late LocalGetProviders sut;
  late PlatformAssetBundleSpy platformAssetBundleSpy;

  setUp(() {
    platformAssetBundleSpy = PlatformAssetBundleSpy();
    sut = LocalGetProviders(
      assetsDataSource: platformAssetBundleSpy
    );

    platformAssetBundleSpy.mock(faker.lorem.word());
  });

  test('Should call datasource with correct values', () async {
    await sut.call();

    verify(() => platformAssetBundleSpy.loadString('assets/providers.json'));
  });

  test('Should return a list of ProviderEntity if success', () async {
    final fakeProviders = random.amount((i) => FakeProvider.makeFakeProvider(), 5);
    final fakeJson = FakeProvider.makeFakeJsonString(fakeProviders);
    platformAssetBundleSpy.mock(fakeJson);
    
    final res = await sut.call();

    expect(res, fakeProviders);
  });

}