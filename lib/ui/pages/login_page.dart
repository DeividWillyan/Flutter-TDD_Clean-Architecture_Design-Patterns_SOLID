import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'password',
                icon: Icon(
                  Icons.lock,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {},
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
