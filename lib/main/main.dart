import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/pages/pages.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: 'Flutter Avaçado',
      theme: ThemeData(
        primaryColor: Colors.purple[600],
        primaryColorDark: Colors.purple[800],
        primaryColorLight: Colors.purple[400],
        accentColor: Colors.purple[600],
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
