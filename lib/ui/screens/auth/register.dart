import 'package:flutter_login2/ui/widgets/auth/register/form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/auth/register';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text('Register')), body: RegisterForm());
  }
}
