import 'package:flutter_login2/api/client.dart';
import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:async';

class RegisterForm extends StatefulWidget {
  /*
  RegisterForm({Key key, this.title}) : super(key: key);
  final String title;*/

  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  final _templateDate = DateFormat("yyyy-MM-dd");
  final _log = Logger();

  String dateOfBirthInString;
  DateTime dateOfBirth;
  bool isDateSelected = false;

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _dateOfBirthController.text = _templateDate.format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = _templateDate.parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.phone),
              labelText: 'Phone number',
            ),
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
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter password';
              }
              return null;
            },
          ),
          Row(children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'Enter your date of birth',
                    labelText: 'Date of birth'),
                controller: _dateOfBirthController,
                keyboardType: TextInputType.datetime,
                validator: (val) => isValidDob(val) ? null : "Not a valid date",
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              tooltip: 'Choose date',
              onPressed: (() {
                _chooseDate(context, _dateOfBirthController.text);
              }),
            )
          ]),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _log.d('Logger is working!');
                APIClient().register(
                  _phoneNumberController.text,
                  _passwordController.text,
                  _dateOfBirthController.text,
                  (response) {
                    if (response.statusCode == 201) {
                      APIClient().login(
                          _phoneNumberController.text, _passwordController.text,
                          (response) {
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
