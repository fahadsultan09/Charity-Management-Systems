import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:notifier/Login/RootPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tadbeer Contributor',
      theme: ThemeData(
        accentColor: CupertinoColors.systemBlue,
      ),
      home: RootPage(
        auth: new Auth(),
      ),
    );
  }
}
