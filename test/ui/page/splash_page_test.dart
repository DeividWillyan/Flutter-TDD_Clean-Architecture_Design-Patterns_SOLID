import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  SplashPresenterSpy presenter;
  StreamController navigateToController;

  setUp(() {
    presenter = SplashPresenterSpy();
    navigateToController = StreamController();

    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  });

  tearDown(() {
    navigateToController.close();
  });

  loadPage(tester) async => await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
            GetPage(
                name: '/any_route',
                page: () => Material(child: Text('fake page')))
          ],
        ),
      );

  testWidgets("Should present spinner on page load",
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Should call loadCurrentAccount in presenter",
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
  });

  testWidgets("Should change page", (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add("/any_route");
    await tester.pumpAndSettle();

    expect(Get.currentRoute, "/any_route");
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets("Should not change page", (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/');
  });
}
