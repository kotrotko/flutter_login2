import 'package:flutter_login2/ui/screens/auth/login.dart';
import 'package:flutter_login2/ui/screens/auth/register.dart';
import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: LoginPage(), routes: <String, WidgetBuilder>{
      LoginPage.routeName: (context) => LoginPage(),
      RegisterPage.routeName: (context) => RegisterPage(),
      Dashboard.routeName: (context) => Dashboard(),
    });
  }
}

void main() {
  runApp(new MyApp());
}
