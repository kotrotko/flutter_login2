import 'package:flutter_login2/api/client.dart';
import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/ui/screens/auth/register.dart';
import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            controller: _userNameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter username';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                APIClient().login(
                    _userNameController.text,
                    (loginResponse) async => {
                          if (loginResponse.statusCode == 200)
                            {
                              getCurrentTokens().then((currentTokens) {
                                Navigator.pushReplacementNamed(
                                    context, Dashboard.routeName,
                                    arguments: AuthTokens(
                                        accessToken: currentTokens.accessToken,
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
    );
  }
}
