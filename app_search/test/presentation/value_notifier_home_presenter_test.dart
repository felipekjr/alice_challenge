import 'package:app_search/src/core/extensions/extensions.dart';
import 'package:app_search/src/domain/entities/entities.dart';
import 'package:app_search/src/domain/usecases/get_providers.dart';
import 'package:app_search/src/presentation/home/home.dart';
import 'package:app_search/src/presentation/ui_state.dart';
import 'package:app_search/src/ui/pages/home/home.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
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
    final providersVM = makeVisibleProviders(fakeProviders);
    getProvidersSpy.mock(fakeProviders);

    await sut.getAll();

    expect(states[0], const UILoadingState());
    expect(states[1], ProvidersLoadedState(providersVM));
    expect(sut.providers, fakeProviders);
    expect(sut.filteredProvidersNotifier.value, providersVM);
  });

  test('Should emit error state if method fails', () async {
    states.clear();
    await sut.getAll();

    expect(states[0], const UILoadingState());
    expect(states[1], const UIErrorState('Erro ao recuperar colaboradores'));
  });

  test('Should filter providers list correctly and emit state', () async {
    final fakeProviders = random.amount((i) => FakeProvider.makeFakeProvider(), 5);
    final text = faker.lorem.word();
    sut.providers = fakeProviders;
    sut.filteredProvidersNotifier.value = makeVisibleProviders(fakeProviders);
    final filteredList = fakeProviders.where((p) => p.name.startsWith(text)).toList();
    final providersWithVisibility = sut.filteredProviders.map((e) => e.copy(
      isVisible: filteredList.any((f) => f.name == e.name)
    )).toList();

    states.clear();
    sut.filterProviders(text);

    expect(sut.filteredProviders, providersWithVisibility);
    expect(states[0], ProvidersFilteredState(providersWithVisibility));
  });

  test('Should dispose notifiers on dispose method', () {
    sut.dispose();

    expect(() => sut.filteredProvidersNotifier.hasListeners, throwsA(isA<FlutterError>()));
    expect(() => sut.stateNotifier.hasListeners, throwsA(isA<FlutterError>()));
  });
}