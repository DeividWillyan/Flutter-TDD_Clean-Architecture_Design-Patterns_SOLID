import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  loadPage(tester) async => await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [GetPage(name: '/', page: () => SplashPage())],
        ),
      );

  testWidgets("Should present spinner on page load", (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
