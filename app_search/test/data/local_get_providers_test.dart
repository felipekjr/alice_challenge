
import 'dart:convert';

import 'package:app_search/src/data/usecases/local_get_providers.dart';
import 'package:app_search/src/domain/helpers/domain_error.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class PlatformAssetBundleSpy extends Mock implements PlatformAssetBundle {
  When mockCall() => when(() => loadString(any()));
  void mock(String response) => mockCall().thenAnswer((_) => Future.value(response));
  void mockError() => mockCall().thenThrow(Exception());
}

void main() {
  late LocalGetProviders sut;
  late PlatformAssetBundleSpy platformAssetBundleSpy;

  setUp(() {
    platformAssetBundleSpy = PlatformAssetBundleSpy();
    sut = LocalGetProviders(
      assetsDataSource: platformAssetBundleSpy
    );

    platformAssetBundleSpy.mock(FakeProvider.makeFakeJsonString([]));
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

  test('Should emit unexpected if got some error', () async {
    platformAssetBundleSpy.mockError();
    expect(() => sut.call(), throwsA(DomainError.unexpected));
  });

}