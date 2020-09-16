import 'package:flutter/material.dart';

import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.all(24),
                  children: [Center(child: CircularProgressIndicator())],
                ),
              );
            }
          });

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login'),
                StreamBuilder<String>(
                    stream: presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: 'User',
                          errorText: snapshot?.data?.isEmpty == true ? null : snapshot.data,
                          icon: Icon(
                            Icons.email,
                          ),
                        ),
                        onChanged: presenter.validateEmail,
                      );
                    }),
                StreamBuilder<String>(
                    stream: presenter.passwordErrorStream,
                    builder: (context, snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: snapshot?.data?.isEmpty == true ? null : snapshot.data,
                          icon: Icon(
                            Icons.lock,
                          ),
                        ),
                        onChanged: presenter.validatePassword,
                      );
                    }),
                StreamBuilder<bool>(
                    stream: presenter.isValidFormStream,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        onPressed: snapshot.data == true ? presenter.auth : null,
                        child: Text('Login'),
                      );
                    }),
                FlatButton(
                  onPressed: () {},
                  child: Text('Registro'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
