import '../entities/provider_entity.dart';

abstract class GetProviders {
  Future<List<ProviderEntity>> call();
}