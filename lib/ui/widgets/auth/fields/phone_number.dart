import 'package:flutter/material.dart';

class PhoneNumberField extends StatefulWidget {
  final _phoneNumberController = TextEditingController();

  @override
  _PhoneNumberFieldState createState() =>
      _PhoneNumberFieldState(_phoneNumberController);
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  _PhoneNumberFieldState(_phoneNumberController);

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        labelText: 'Phone number',
      ),
      //controller: _phoneNumberController;,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter phone number';
        }
        return null;
      },
    );
  }
}
