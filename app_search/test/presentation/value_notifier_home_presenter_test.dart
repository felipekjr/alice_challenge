import 'package:app_search/src/domain/entities/entities.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:app_search/src/presentation/helpers/ui_state.dart';
import 'package:app_search/src/presentation/value_notifier_home_presenter.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class GetProvidersSpy extends Mock implements GetProviders {
  When mockCall() => when(() => call());
  void mock(List<ProviderEntity> providers) => 
    mockCall().thenAnswer((_) => Future.value(providers));
}

void main() {
  late ValueNotifierHomePresenter sut;
  late GetProvidersSpy getProvidersSpy;
  final List<UIState> states = [];

  setUp((){
    getProvidersSpy = GetProvidersSpy();
    sut = ValueNotifierHomePresenter(
      getProviders: getProvidersSpy
    );
    sut.stateNotifier.addListener(() {
      states.add(sut.stateNotifier.value);
    });
  });

  test('Should call correct useCase on getAll method', () async {
    await sut.getAll();

    verify(() => getProvidersSpy.call());
  });

  test('Should set providers, filteredProviders and emit correct states on success', () async {
    states.clear();
    final fakeProviders = random.amount((i) => FakeProvider.makeFakeProvider(), 5);
    getProvidersSpy.mock(fakeProviders);

    await sut.getAll();

    expect(states[0], const UILoadingState());
    expect(states[1], const UIInitialState());
    expect(sut.providers, fakeProviders);
    expect(sut.filteredProvidersNotifier.value, fakeProviders);
  });

  test('Should emit error state if method fails', () async {
    await sut.getAll();

    expect(states[0], const UILoadingState());
    expect(states[1], const UIErrorState('Erro ao recuperar colaboradores'));
  });
}