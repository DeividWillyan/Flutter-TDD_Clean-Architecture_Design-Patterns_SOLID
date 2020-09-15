import 'package:flutter/material.dart';

import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
            TextField(
              decoration: InputDecoration(
                hintText: 'User',
                icon: Icon(
                  Icons.email,
                ),
              ),
              onChanged: presenter.validateEmail,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(
                  Icons.lock,
                ),
              ),
              onChanged: presenter.validatePassword,
            ),
            RaisedButton(
              onPressed: null,
              child: Text('Login'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Registro'),
            ),
          ],
        ),
      ),
    );
  }
}
