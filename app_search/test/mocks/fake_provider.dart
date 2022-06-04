import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:faker/faker.dart';

class FakeProvider {
  static ProviderEntity makeFakeProvider() => ProviderEntity(
    name: faker.lorem.word()
  );

  static String makeFakeJsonString(List<ProviderEntity> providers) {
    return providers.map((e) => '{"name": "${e.name}"}')
      .toList()
      .toString();
  }
}