import 'package:flutter_login2/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Dashboard'), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        tooltip: 'Log out',
        onPressed: () {
          logout(context);
        },
      ),
    ]);
  }
}
