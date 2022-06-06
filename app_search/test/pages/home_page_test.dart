import 'package:app_search/src/presentation/presentation.dart';
import 'package:app_search/src/ui/pages/home/home.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class HomePresenterSpy extends Mock implements HomePresenter {}

void main() {
  late ValueNotifier<UIState> stateNotifier;
  late ValueNotifier<List<ProviderViewModel>> providerNotifier;
  late HomePresenterSpy presenterSpy;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    presenterSpy = HomePresenterSpy();
    stateNotifier = ValueNotifier(const UIInitialState());
    providerNotifier = ValueNotifier([]);
  });

  Future<void> loadPage(WidgetTester tester) async {
    when(() => presenterSpy.stateNotifier).thenAnswer((_) => stateNotifier);
    when(() => presenterSpy.filteredProvidersNotifier).thenAnswer((_) => providerNotifier);
    final Widget page = MaterialApp(
      home: HomePage(presenter: presenterSpy),
    );
    await tester.pumpWidget(page);
  }

  testWidgets('Should render page with initial values', (WidgetTester tester) async {
    stateNotifier.value = const UILoadingState();
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

   testWidgets('Should render page correctly when load providers', (WidgetTester tester) async {
    stateNotifier.value = ProvidersLoadedState(makeVisibleProviders(random.amount((i) => FakeProvider.makeFakeProvider(), 5)));
    await loadPage(tester);

    for (var e in providerNotifier.value) {
      expect(find.text(e.name), findsOneWidget);
    }
  });
}