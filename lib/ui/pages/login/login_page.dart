import 'package:flutter/material.dart';
import 'package:flutter_avancado/utils/i18n/resources.dart';
import 'package:get/route_manager.dart';

import './login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SimpleDialog(
                  contentPadding: EdgeInsets.all(24),
                  children: [Center(child: CircularProgressIndicator())],
                ),
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error),
                backgroundColor: Colors.red,
              ));
            }
          });

          widget.presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
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
                    stream: widget.presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: 'User',
                          errorText: snapshot?.data?.isEmpty == true ? null : snapshot.data,
                          icon: Icon(
                            Icons.email,
                          ),
                        ),
                        onChanged: widget.presenter.validateEmail,
                      );
                    }),
                StreamBuilder<String>(
                    stream: widget.presenter.passwordErrorStream,
                    builder: (context, snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: snapshot?.data?.isEmpty == true ? null : snapshot.data,
                          icon: Icon(
                            Icons.lock,
                          ),
                        ),
                        onChanged: widget.presenter.validatePassword,
                      );
                    }),
                StreamBuilder<bool>(
                    stream: widget.presenter.isValidFormStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: snapshot.data == true ? widget.presenter.auth : null,
                        child: Text('Login'),
                      );
                    }),
                TextButton(
                  onPressed: () {},
                  child: Text(R.strings.addAccount),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }
}
