
import 'package:flutter/material.dart';
import 'package:notifier/Home/Home.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:notifier/Login/Login.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if (authStatus == AuthStatus.notSignedIn)
      return new LoginPage();
    else
      return  Home();
  }
}