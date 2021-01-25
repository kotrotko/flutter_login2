import 'package:flutter_login2/api/client.dart';
import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';

import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
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
                return 'Enter first name';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                APIClient().register(
                  _userNameController.text,
                  '123',
                  (response) {
                    if (response.statusCode == 201) {
                      APIClient().login(_userNameController.text, (response) {
                        if (response.statusCode == 200) {
                          getCurrentTokens().then((currentTokens) async {
                            Navigator.pushReplacementNamed(
                                context, Dashboard.routeName);
                          });
                          print("Validation Error");
                        }
                      });
                    }
                  },
                );
              }
              ;
            },
            child: Text("Register"),
          ),
        ]),
      ),
    );
  }
}
