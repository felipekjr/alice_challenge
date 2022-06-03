
import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
    await assetsDataSource.loadString('assets/providers.json');
    return [];
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
}