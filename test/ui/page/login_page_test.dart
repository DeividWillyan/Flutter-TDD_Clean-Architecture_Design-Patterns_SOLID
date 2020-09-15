import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avancado/ui/pages/login/login_presenter.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;

  setUp(() {
    presenter = LoginPresenterSpy();
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
}
