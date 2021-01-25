import 'package:flutter_login2/ui/widgets/auth/login/form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'auth/login';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text('Login')), body: LoginForm());
  }
}
