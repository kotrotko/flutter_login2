import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/ui/screens/auth/login.dart';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = new FlutterSecureStorage();

logout(BuildContext context) {
  AuthTokens(accessToken: null, refreshToken: null).save();

  Navigator.pushReplacementNamed(context, LoginPage.routeName);
}
