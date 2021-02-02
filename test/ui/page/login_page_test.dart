import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avancado/ui/pages/login/login_presenter.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;
  StreamController<String> mainErrorController;
  StreamController<String> navigateToController;

  initStreams() {
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    mainErrorController = StreamController<String>();
    navigateToController = StreamController<String>();
  }

  mockStreams() {
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isValidFormStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  disposeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    navigateToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    initStreams();
    mockStreams();

    final loginPage = GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage(presenter)),
        GetPage(name: '/surveys', page: () => Scaffold(body: Text('Enquetes'))),
      ],
    );
    await tester.pumpWidget(loginPage);
  }

  tearDown(disposeStreams);

  testWidgets('Should load LoginPage with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final userTextChildren = find.descendant(
        of: find.bySemanticsLabel('User'), matching: find.byType(Text));
    expect(userTextChildren, findsOneWidget);

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration.hintText == 'User'));
    expect(userTextError.decoration.errorText, null);

    final passTextChildren = find.descendant(
        of: find.bySemanticsLabel('Password'), matching: find.byType(Text));
    expect(passTextChildren, findsOneWidget);

    final passwordTextError = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration.hintText == 'Password'));
    expect(passwordTextError.decoration.errorText, null);

    final loginButton = tester.widget<RaisedButton>(find.byWidgetPredicate(
        (widget) =>
            widget is RaisedButton && (widget.child as Text).data == 'Login'));
    expect(loginButton.onPressed, null);
  });

  testWidgets('Should call validate with correct values ',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('User'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Password'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration.hintText == 'User'));
    expect(userTextError.decoration.errorText, null);
  });

  testWidgets('Should present error if clear email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel('User'), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets('Should present error if password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error password');
    await tester.pump();

    expect(find.text('any error password'), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump();

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration.hintText == 'Password'));
    expect(userTextError.decoration.errorText, null);
  });

  testWidgets('Should present error if clear password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('');
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel('Password'), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final loginButton = tester.widget<RaisedButton>(find.byWidgetPredicate(
        (widget) =>
            widget is RaisedButton && (widget.child as Text).data == 'Login'));
    expect(loginButton.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is not valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final loginButton = tester.widget<RaisedButton>(find.byWidgetPredicate(
        (widget) =>
            widget is RaisedButton && (widget.child as Text).data == 'Login'));
    expect(loginButton.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final btnLogin = find.byWidgetPredicate((widget) =>
        widget is RaisedButton &&
        (widget.child as Text).data == 'Login' &&
        widget.onPressed != null);
    expect(btnLogin, findsOneWidget);

    await tester.tap(btnLogin);
    await tester.pump();

    verify(presenter.auth()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentications fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() => verify(presenter.dispose()).called(1));
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/surveys');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/surveys');
    expect(find.text('Enquetes'), findsOneWidget);
  });
}
