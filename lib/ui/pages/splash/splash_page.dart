import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  SplashPage({this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return Builder(builder: (context) {
      presenter.navigateToStream.listen((page) {
        if (page?.isNotEmpty == true) Get.offAllNamed(page);
      });
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
