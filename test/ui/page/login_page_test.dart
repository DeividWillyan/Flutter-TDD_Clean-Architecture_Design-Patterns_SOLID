import 'package:flutter/material.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should load LoginPage with correct initial state', (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
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
}
