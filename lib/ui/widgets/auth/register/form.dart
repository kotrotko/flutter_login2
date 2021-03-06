import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:flutter_login2/api/client.dart';
import 'package:flutter_login2/models/auth.dart';

import 'package:flutter_login2/ui/screens/dashboard/dashboard.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key, this.title}) : super(key: key);
  final String title;

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

  DateTime selectedDate = DateTime.now();

  Future _chooseDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
      //if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date = _templateDate.format(picked);

        _dateOfBirthController.text = date;
      });
  }

/*
  DateTime convertToDate(String input) {
    try {
      var d = _templateDate.parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }
*/
  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

/*
  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }
*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(children: <Widget>[
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
                        labelText: 'Date of birth'),
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter date of birth';
                      }
                      return null;
                    },
                    //validator: (val) => isValidDob(val) ? null : "Not a valid date",
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  tooltip: 'Choose date',
                  onPressed: (() {
                    _chooseDate(context);
                  }),
                )
              ]),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    APIClient().register(
                      _phoneNumberController.text,
                      _passwordController.text,
                      _dateOfBirthController.text,
                      (response) {
                        if (response.statusCode == 201) {
                          APIClient().login(_phoneNumberController.text,
                              _passwordController.text, (response) {
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
          ],
        ),
      ),
    );
  }
}
