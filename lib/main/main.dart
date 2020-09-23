import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_avancado/data/usecases/usecases.dart';
import 'package:flutter_avancado/infra/cache/cache.dart';
import 'package:flutter_avancado/infra/http/http.dart';
import 'package:flutter_avancado/main/factories/factories.dart';
import 'package:flutter_avancado/presentation/presenters/presenters.dart';
import 'package:flutter_avancado/ui/pages/pages.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

void main() {
  runApp(ModularApp(module: AppModule()));
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
      initialRoute: '/login',
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Client()),
        Bind((i) => HttpAdpter(i.get())),
        Bind((i) => RemoteAuthentication(httpClient: i.get(), url: 'http://fordevs.herokuapp.com/api/login')),
        Bind((i) => FlutterSecureStorage()),
        Bind((i) => LocalStorageAdpter(secureStorage: i.get())),
        Bind((i) => LocalSaveCurrentAccout(saveSecureCacheStorage: i.get())),
        Bind((i) => makeLoginValidation()),
        Bind((i) =>
            GetxLoginPresenter(authentication: i.get(), saveCurrentAccount: i.get(), validation: i.get())),
        Bind((i) => LoginPage(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/login', child: (_, __) => LoginPage(Modular.get())),
        ModularRouter('/surveys', child: (_, __) => Scaffold(body: Text('Enquetes'))),
      ];

  @override
  Widget get bootstrap => App();
}
