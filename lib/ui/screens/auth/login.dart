import 'package:flutter_login2/ui/widgets/auth/login/form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Log In')),
      body: Column(children: <Widget>[
        SizedBox(
          height: 44.0,
        ),
        Text(
          'Welcome to Login Page',
          style: TextStyle(
            fontSize: 22.00,
          ),
        ),
        Expanded(child: LoginForm()),
      ]),
    );
  }
}
