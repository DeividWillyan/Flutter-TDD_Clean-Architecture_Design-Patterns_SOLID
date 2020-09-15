import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avancado/ui/pages/login/login_presenter.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;

  setUp(() {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
  });

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
  });

  testWidgets('Should load LoginPage with correct initial state', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    final userTextChildren = find.descendant(
      of: find.bySemanticsLabel('User'),
      matching: find.byType(Text),
    );
    expect(userTextChildren, findsOneWidget);

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration.hintText == 'User',
    ));
    expect(userTextError.decoration.errorText, null);

    final passTextChildren = find.descendant(
      of: find.bySemanticsLabel('Password'),
      matching: find.byType(Text),
    );
    expect(passTextChildren, findsOneWidget);

    final passwordTextError = tester.widget<TextField>(find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration.hintText == 'Password',
    ));
    expect(passwordTextError.decoration.errorText, null);

    final loginButton = tester.widget<RaisedButton>(
      find.byWidgetPredicate((widget) => widget is RaisedButton && (widget.child as Text).data == 'Login'),
    );
    expect(loginButton.onPressed, null);
  });

  testWidgets('Should call validate with correct values ', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('User'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Password'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    emailErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    emailErrorController.add(null);
    await tester.pump();

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration.hintText == 'User',
    ));
    expect(userTextError.decoration.errorText, null);
  });

  testWidgets('Should present error if clear email is invalid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    emailErrorController.add('');
    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('User'), matching: find.byType(Text)), findsOneWidget);
  });

  testWidgets('Should present error if password is invalid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    passwordErrorController.add('any error password');
    await tester.pump();

    expect(find.text('any error password'), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    passwordErrorController.add(null);
    await tester.pump();

    final userTextError = tester.widget<TextField>(find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration.hintText == 'Password',
    ));
    expect(userTextError.decoration.errorText, null);
  });

  testWidgets('Should present error if clear password is invalid', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);

    passwordErrorController.add('');
    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Password'), matching: find.byType(Text)), findsOneWidget);
  });
}