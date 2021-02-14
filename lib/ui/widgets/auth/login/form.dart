import 'package:flutter/material.dart';
import 'package:flutter_login2/api/client.dart';
import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/ui/screens/auth/register.dart';
import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';

import 'package:flutter_login2/ui/widgets/auth/fields/phone_number.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            PhoneNumberField(),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.phone), labelText: 'Phone number'),
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter phone number';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_open), labelText: 'Password'),
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter password';
                }
                return null;
              },
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  APIClient().login(
                      _phoneNumberController.text,
                      _passwordController.text,
                      (loginResponse) async => {
                            if (loginResponse.statusCode == 200)
                              {
                                getCurrentTokens().then((currentTokens) {
                                  Navigator.pushReplacementNamed(
                                      context, Dashboard.routeName,
                                      arguments: AuthTokens(
                                          accessToken:
                                              currentTokens.accessToken,
                                          refreshToken:
                                              currentTokens.refreshToken));
                                }),
                              }
                            else
                              {
                                print('fail'),
                              }
                          });
                }
              },
              child: Text("Log in"),
            ),
            FlatButton(
              onPressed: () async {
                Navigator.pushNamed(context, RegisterPage.routeName);
              },
              child: Text("Register"),
            ),
          ]),
        ),
      ),
    );
  }
}
